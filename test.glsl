precision mediump float;

uniform vec2 u_resolution; 
uniform float u_time; 

void main() {
    vec2 uv = (gl_FragCoord.xy / u_resolution.xy)-0.5;
    float t = u_time;
    uv.y *= u_resolution.y/u_resolution.x; 

    vec3 color = vec3(1., 1.0, .0); 


    //OUTPUT
    gl_FragColor = vec4(color, 1.0);
}