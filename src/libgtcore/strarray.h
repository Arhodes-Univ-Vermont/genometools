/*
  Copyright (c) 2007-2008 Gordon Gremme <gremme@zbh.uni-hamburg.de>
  Copyright (c) 2007-2008 Center for Bioinformatics, University of Hamburg

  Permission to use, copy, modify, and distribute this software for any
  purpose with or without fee is hereby granted, provided that the above
  copyright notice and this permission notice appear in all copies.

  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*/

#ifndef STRARRAY_H
#define STRARRAY_H

#include "libgtcore/str.h"

/* the string array class  */
typedef struct StrArray StrArray;

StrArray*     strarray_new(void);
StrArray*     strarray_new_file(const char *path);
void          strarray_add_cstr(StrArray*, const char*);
void          strarray_add_cstr_nt(StrArray*, const char*, unsigned long);
void          strarray_add(StrArray*, const Str*);
const char*   strarray_get(const StrArray*, unsigned long strnum);
/* returns an internal Str pointer (i.e., _not_ a new reference!) */
Str*          strarray_get_str(const StrArray*, unsigned long strnum);
void          strarray_set_size(StrArray*, unsigned long);
unsigned long strarray_size(const StrArray*); /* returns number of strings */
void          strarray_delete(StrArray*);

#endif
