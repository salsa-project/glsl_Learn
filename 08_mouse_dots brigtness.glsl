precision mediump float;

#define max .51

uniform vec2 u_resolution; 
uniform float u_time; 
uniform vec2 u_mouse;  

float circleShap(vec2 uv, vec2 pos, float r){
    float radius = .002+r;
    float d = length(uv-pos);
    d = smoothstep(radius, radius-0.001, d);

    return d;
}

void main() {
    vec2 uv = (gl_FragCoord.xy / u_resolution.xy)-0.5;
    float t = u_time;
    vec2 mouse = (u_mouse/u_resolution)-.5; 
    vec3 color = vec3(.0);
    float r;
    vec3 col = vec3(1.);

    const float rate = .05;
    float mouseAccurency = (rate*70.)/100.;

    for(float j = -0.5; j < max; j+=rate) {
        for(float i = -0.5; i < max; i+=rate) {
            if((mouse.x >= i-rate+(mouseAccurency) && mouse.x <= i+rate-(mouseAccurency)) && (mouse.y >= j-rate+(mouseAccurency) && mouse.y <= j+rate-(mouseAccurency))){
                r =(abs(sin(t*4.)/2.)*.025)+0.005;
                col = vec3(1., 0., 1.);
            }else{
                r = 0.;
                col = vec3(1.);
            }

            float circle = circleShap(uv, vec2(i, j), r);

            color+= circle*col;
        }
    }


    //OUTPUT
    gl_FragColor = vec4(color, 1.0);
}