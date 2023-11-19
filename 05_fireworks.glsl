#define NUM_EXPLOSIONS 3.
#define NUM_PARTICLES  30.

precision mediump float;


uniform vec2 u_resolution; 
uniform float u_time;

vec2 Hash12(float t){
    float x = fract(sin(t*674.3)*453.2);
    float y = fract(sin(t+x*714.3)*263.2);
    return vec2(x, y);
}
vec2 Hash12_Polar(float t){
    float a = fract(sin(t*674.3)*453.2)*6.2832;
    float d = fract(sin(t+a*714.3)*263.2);
    return vec2(sin(a), cos(t+a))*d;
}

float Explosion(vec2 uv, float t){
    float sparks = 0.;
    for(float i = .0; i < NUM_PARTICLES; i++){
        vec2 dir = Hash12_Polar(i+1.)*.5;
        float d = length(uv-dir*t);
        float brigtness = mix(.001, .001, smoothstep(.05,0.,t));
        brigtness *= sin(t*20.+i)*.5+.5;
        brigtness *= smoothstep(1., .75, t);
        sparks+= brigtness/d;
    }
    return sparks;
}


void main() {
    vec2 uv = (gl_FragCoord.xy / u_resolution.xy)-0.5;
    uv.y *= u_resolution.y/u_resolution.x; 
    vec3 color = vec3(.0);

    for(float i = 0.; i<NUM_EXPLOSIONS; i++){
        float t = u_time+i/NUM_EXPLOSIONS;
        float frt = fract(t);
        float flt = floor(t);
        
        vec3 col = sin(vec3(.34, 54, .43)*flt)*.25+.75;
        vec2 offs = Hash12(i+1.+flt)-.5;
        offs*= vec2(1.0, 1.);

        color+= Explosion(uv-offs, frt)*col; 
    }
    //OUTPUT
    gl_FragColor = vec4(color, 1.0);
}