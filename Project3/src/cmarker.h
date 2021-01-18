//
// Created by 俞三岁 on 2020/12/13.
//

#ifndef SRC_CMARKER_H
#define SRC_CMARKER_H

void
write_app0(compress_io *cio);

void
write_sof0(compress_io *cio, bmp_info *binfo);

void
write_sos(compress_io *cio);

void
write_dqt(compress_io *cio);

int
get_ht_length(UINT8 *nrcodes);

void
write_htable(compress_io *cio,
             UINT8 *nrcodes, UINT8 *values, int len, UINT8 index);

void
write_dht(compress_io *cio);

void
write_file_header(compress_io *cio);

void
write_frame_header(compress_io *cio, bmp_info *binfo);

void
write_scan_header(compress_io *cio);

void
write_file_trailer(compress_io *cio);


#endif //SRC_CMARKER_H
