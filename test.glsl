#define MAX_PARTICLES 50.
#define MAX_circles 10.


precision mediump float;

uniform vec2 u_resolution; 
uniform float u_time;
uniform vec2 u_mouse;


vec3 red = vec3(1., .0, .0);
vec3 green = vec3(0., 1.0, .0);
vec3 blue = vec3(0., .0, 1.0);
vec3 cyan = vec3(0., 1.0, 1.0);
vec3 yellow = vec3(1., 1.0, .0);
vec3 pink = vec3(1., .0, 1.0);
vec3 purple = vec3(.5, .0, 1.0);
vec3 white = vec3(1., 1.0, 1.0);


float Firework(vec2 uv, vec2 pos){
    float brigtness = 0.00004;
    float d = length(uv-pos);
    float c = brigtness/d;
    
    return c;
}


void main() {
    vec2 uv = (gl_FragCoord.xy / u_resolution.xy)-0.5;
    uv.y *= u_resolution.y/u_resolution.x;
    float t = u_time;
    float frt = fract(t);
    float flt = floor(t);
    vec2 mouse = (u_mouse/u_resolution)-.5;
    vec3 color = vec3(.0);

    for(float j = 1.; j <= MAX_circles; j++){
        float n = 1.0+j/abs(sin(t));
        for(float i = 1.; i <= MAX_PARTICLES; i++){
            float particle = Firework(uv, vec2(sin((t)+i)/n, cos((t*2.)+i)/n/2.));

            color += particle;
        }
    }



    //OUTPUT
    gl_FragColor = vec4(color, 1.0);
}