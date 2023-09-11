#ifndef thing_tex_include_file
#define thing_tex_include_file

#ifdef __cplusplus
extern "C" {
#endif

#define thing_tex_width 64
#define thing_tex_height 64
#define thing_tex_size 4098
#define thing_tex ((gfx_sprite_t*)thing_tex_data)
extern unsigned char thing_tex_data[4098];

#ifdef __cplusplus
}
#endif

#endif
