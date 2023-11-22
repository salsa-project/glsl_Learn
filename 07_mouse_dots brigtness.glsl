precision lowp float;

#define max 4.

uniform vec2 u_resolution; 
uniform float u_time; 
uniform vec2 u_mouse;  

float circleShap(vec2 uv, vec2 pos, float gamma){
    float brigtness = 0.0002+gamma;
    float d = length(uv-pos);
    float res = brigtness/d;
    
    return res;
}

void main() {
    vec2 uv = (gl_FragCoord.xy / u_resolution.xy)-.5;
    float t = u_time;
    vec2 mouse = u_mouse;
    vec2 md = (mouse/u_resolution)-.5;
    vec3 color = vec3(.0); 
    for(float j = -0.5; j < max/10.; j+=.1) {
        for(float i = -0.5; i < max; i+=.1) {
            float g = 0.;

            if((md.x >= (i-.1)+0.07 && md.x <= i+.1-0.07) && (md.y >= (j-.1)+0.07 && md.y <= j+.1-0.07)){
                g = abs(sin(t*5.)/2.)/100.;
            }
            float circle = circleShap(uv, vec2(i,j), g);

            if(j > -0.1 && i < -.1){
               color += circle*vec3(1.,0.,1.); 
            }else{
                color += circle;
            }
        }
    }


    //OUTPUT
    gl_FragColor = vec4(color, 1.0);
}