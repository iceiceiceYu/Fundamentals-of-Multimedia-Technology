//
// Created by 俞三岁 on 2020/12/13.
//

#ifndef SRC_RDBMP_H
#define SRC_RDBMP_H

UINT32
extract_uint(const UINT8 *dataptr, UINT32 start, UINT32 len);

int
get_file_size(FILE *bmp_fp);

void
read_bmp(FILE *bmp_fp, bmp_info *binfo);

#endif //SRC_RDBMP_H
