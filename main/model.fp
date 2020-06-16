varying mediump vec2 var_texcoord0;                 //Original texture coordinates of current pixel

uniform mediump sampler2D texture_sampler;          //I'm assuming this is objects original texture
uniform mediump sampler2D palette;                  //Texture of color palettes (palette colors goes in rows)
uniform lowp vec4 params;
//uniform mediump float palette_count = 4.0;          //Tells the shader how many palettes you have. 4.0 is for example project
//uniform mediump float palette_index = 0.0;          //Tells the shader which palette to choose

void main()
{
  float palette_count = params.x;
  float palette_index = params.y;
  float mediump  increment = 1.0/palette_count;                        //Value for getting palette index
  float mediump  y = increment * palette_index + increment * 0.5;      // + safety measure for floating point imprecision
  vec4 mediump color = texture2D(texture_sampler, var_texcoord0.xy);  //Original grayscale color used as collumn index
  vec4 mediump new_color = texture2D(palette, vec2(color.r, y));     //get color from palette texture
  float mediump a = step(0.00392, color.a);                           //check if transparent color is less than 1/255 for backgrounds
  new_color.a *= a;                                           //if BG is transparent, then alpha is multiplied by 0
  gl_FragColor = new_color;                                   //Set output color
}