precision mediump float;

uniform vec2 u_resolution; 
uniform float u_time; 

// raycasting
float DistLine(vec3 ro, vec3 rd, vec3 p){
    return length(cross(p-ro, rd)) / length(rd);
}
float DrawPoint(vec3 ro, vec3 rd, vec3 p){
    float d = DistLine(ro, rd, p);
    d = smoothstep(.06, .05, d);

    return d;
}

void main() {
    vec2 uv = (gl_FragCoord.xy / u_resolution.xy)-0.5;
    float t = u_time;
    uv.y *= u_resolution.y/u_resolution.x; 

    vec3 color = vec3(.0, .0, .0); 

    // ray origin (camera/start)
    vec3 ro = vec3(3.*sin(t), .0, -3.*cos(t));
    // look at point (camera will look at this point)
    vec3 lookat = vec3(.0);

    float zoom= 1.;
    /* 
        c: center of the screen
        f: forward (from c)
        r: right (of the c)
        u: upward (of the c)
        i: intercept of the ray on the screen (ray from the camera to the object.. sreen is between them)
     */
    vec3 f = normalize(lookat-ro);
    vec3 r = cross(vec3(.0, 1., 0.), f);
    vec3 u = cross(f, r);
    vec3 c = ro + f*zoom;
    vec3 i = c + uv.x*r + uv.y*u;

    //ray direction
    vec3 rd = i-ro;

    // the ray casts
    float d = 0.;

    d += DrawPoint(ro, rd, vec3(0., 0., 0.)-.5);
    d += DrawPoint(ro, rd, vec3(0., 0., 1.)-.5);
    d += DrawPoint(ro, rd, vec3(0., 1., 0.)-.5);
    d += DrawPoint(ro, rd, vec3(0., 1., 1.)-.5);
    d += DrawPoint(ro, rd, vec3(1., 0., 0.)-.5);
    d += DrawPoint(ro, rd, vec3(1., 0., 1.)-.5);
    d += DrawPoint(ro, rd, vec3(1., 1., 0.)-.5);
    d += DrawPoint(ro, rd, vec3(1., 1., 1.)-.5);



    //OUTPUT
    gl_FragColor = vec4(d);
}