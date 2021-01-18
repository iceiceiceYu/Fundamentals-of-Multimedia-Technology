/** 
 * @file cio.c
 * @brief memory manager and operations for compressing JPEG IO.
 */

#include <string.h>
#include "cjpeg.h"
#include "cio.h"


/*
 * flush input and output of compress IO.
 */


bool
flush_cin_buffer(void *cio) {
    mem_mgr *in = ((compress_io *) cio)->in;
    size_t len = in->end - in->set;
    memset(in->set, 0, len);
    if (fread(in->set, sizeof(UINT8), len, in->fp) != len)
        return false;
    in->pos = in->set;
    return true;
}

bool
flush_cout_buffer(void *cio) {
    mem_mgr *out = ((compress_io *) cio)->out;
    size_t len = out->pos - out->set;
    if (fwrite(out->set, sizeof(UINT8), len, out->fp) != len)
        return false;

#ifdef REVERSED
    fseek(out->fp, -len * 2, SEEK_CUR);
#endif

    memset(out->set, 0, len);
    out->pos = out->set;
    return true;
}


/*
 * init memory manager.
 */

void
init_mem(compress_io *cio,
         FILE *in_fp, int in_size, FILE *out_fp, int out_size) {
    cio->in = (mem_mgr *) malloc(sizeof(mem_mgr));
    if (!cio->in)
        err_exit(BUFFER_ALLOC_ERR);
    cio->in->set = (UINT8 *) malloc(sizeof(UINT8) * in_size);
    if (!cio->in->set)
        err_exit(BUFFER_ALLOC_ERR);
    cio->in->pos = cio->in->set;
    cio->in->end = cio->in->set + in_size;
    cio->in->flush_buffer = flush_cin_buffer;
    cio->in->fp = in_fp;

    cio->out = (mem_mgr *) malloc(sizeof(mem_mgr));
    if (!cio->out)
        err_exit(BUFFER_ALLOC_ERR);
    cio->out->set = (UINT8 *) malloc(sizeof(UINT8) * out_size);
    if (!cio->out->set)
        err_exit(BUFFER_ALLOC_ERR);
    cio->out->pos = cio->out->set;
    cio->out->end = cio->out->set + out_size;
    cio->out->flush_buffer = flush_cout_buffer;
    cio->out->fp = out_fp;

    cio->temp_bits.len = 0;
    cio->temp_bits.val = 0;
}

void
free_mem(compress_io *cio) {
    fflush(cio->out->fp);
    free(cio->in->set);
    free(cio->out->set);
    free(cio->in);
    free(cio->out);
}


/*
 * write operations.
 */

void
write_byte(compress_io *cio, UINT8 val) {
    mem_mgr *out = cio->out;
    *(out->pos)++ = val & 0xFF;
    if (out->pos == out->end) {
        if (!(out->flush_buffer)(cio))
            err_exit(BUFFER_WRITE_ERR);
    }
}

void
write_word(compress_io *cio, UINT16 val) {
    write_byte(cio, (val >> 8) & 0xFF);
    write_byte(cio, val & 0xFF);
}

void
write_marker(compress_io *cio, JPEG_MARKER mark) {
    write_byte(cio, 0xFF);
    write_byte(cio, (int) mark);
}

void
write_bits(compress_io *cio, BITS bits) {
    /******************************************************/
    /*                                                    */
    /*            finish the missing codes                */
    /*                                                    */
    /******************************************************/

    BITS *tmp = &(cio->temp_bits);
    UINT16 word;
    UINT8 byte_1, byte_2;
    int len = bits.len + tmp->len - 16;
    if (len >= 0) {
        // 去除开始的"0"位
        word = tmp->val | bits.val >> len;

        // 以字节为单位写入数据
        byte_1 = word >> 8;
        write_byte(cio, byte_1);

        // 如果为0xFF，则插入0x00
        if (byte_1 == 0xFF) {
            write_byte(cio, 0);
        }

        // 以字节为单位写入数据
        byte_2 = word & 0xFF;
        write_byte(cio, byte_2);

        // 如果为0xFF，则插入0x00
        if (byte_2 == 0xFF) {
            write_byte(cio, 0);
        }

        tmp->len = len;
        tmp->val = bits.val << (16 - len);
    } else {
        tmp->len = 16 + len;
        tmp->val |= bits.val << -len;
    }
}

void
write_align_bits(compress_io *cio) {
    /******************************************************/
    /*                                                    */
    /*            finish the missing codes                */
    /*                                                    */
    /******************************************************/

    // 写入align_bits，对数据区末尾不满1个字节的数据在后面填充"1"位
    BITS *tmp = &(cio->temp_bits);
    BITS align_bits;
    align_bits.len = 8 - tmp->len % 8;
    align_bits.val = (UINT16) ~0x0 >> tmp->len % 8;
    UINT8 byte;
    write_bits(cio, align_bits);

    // 如果align_bits长度为0，代表数据区末尾恰好满1个字节，直接写入数据即可
    if (tmp->len == 8) {
        byte = tmp->val >> 8;
        write_byte(cio, byte);

        // 如果为0xFF，则插入0x00
        if (byte == 0xFF) {
            write_byte(cio, 0);
        }
    }
}

