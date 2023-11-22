precision mediump float;

uniform vec2 u_resolution; 
uniform float u_time; 
uniform vec2 u_mouse;  

void main() {
    vec2 uv = (gl_FragCoord.xy / u_resolution.xy)-0.5;
    float t = u_time;
    uv.y *= u_resolution.y/u_resolution.x;
    vec2 mouse = (u_mouse/u_resolution)-.5; 

    vec3 color = vec3(1., .0, 1.0); 


    //OUTPUT
    gl_FragColor = vec4(color, 1.0);
}