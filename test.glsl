#define MAX_PARTICLES 10.

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

vec2 Hash12(float n, float t){
    float x = abs(sin(n))-.5;
    float y = abs(cos(n))-.5;

    return vec2(x, y);
}

float Firework(vec2 uv, vec2 pos){
    float brigtness = 0.002;
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

    for(float i = 0.; i < MAX_PARTICLES; i++){
        float particle = Firework(uv, vec2(Hash12(i, t)));

        color += particle;

    }


    //OUTPUT
    gl_FragColor = vec4(color, 1.0);
}