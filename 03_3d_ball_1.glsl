precision mediump float;

uniform vec2 u_resolution; 
uniform float u_time; 

// raycasting
float DistLine(vec3 ro, vec3 rd, vec3 p){
    return length(cross(p-ro, rd)) / length(rd);
}

void main() {
    vec2 uv = (gl_FragCoord.xy / u_resolution.xy)-0.5;
    float t = u_time;
    uv.y *= u_resolution.y/u_resolution.x; 
    vec3 color = vec3(.0); 

    // position of the camera/start
    vec3 ro = vec3(0., .0, -2.);
    //ray direction
    vec3 rd = vec3(uv.x, uv.y, 0.)-ro;
    // position of the ball
    vec3 p = vec3(0., 0., 2.+ 3.);

    // the ray casts
    float d = DistLine(ro, rd, p);

    d = smoothstep(.1, .09, d);



    //OUTPUT
    gl_FragColor = vec4(d);
}