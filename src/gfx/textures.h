#ifndef textures_appvar_include_file
#define textures_appvar_include_file

#ifdef __cplusplus
extern "C" {
#endif

#define textures_palette_offset 0
#define brick_wall_width 64
#define brick_wall_height 128
#define textures_textures_brick_wall_index 0
#define brick_wall ((gfx_sprite_t*)textures_appvar[0])
#define portrait_width 64
#define portrait_height 128
#define textures_textures_portrait_index 1
#define portrait ((gfx_sprite_t*)textures_appvar[1])
#define door_gray_width 64
#define door_gray_height 128
#define textures_textures_door_gray_index 2
#define door_gray ((gfx_sprite_t*)textures_appvar[2])
#define textures_entries_num 3
extern unsigned char *textures_appvar[3];
unsigned char textures_init(void);

#ifdef __cplusplus
}
#endif

#endif
