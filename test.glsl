precision mediump float;

uniform vec2 u_resolution; 
uniform float u_time;

float circleShap(vec2 uv, vec2 pos){
    float radius= .01;
    float d = length(uv.xy + pos.xy);
    float c = smoothstep(radius, radius - .001, d);
    return c;
}
float edge(float start, float end, float axie){
    float e = smoothstep(start, end, axie);
    return e;
}

float rectShap(vec2 width, vec2 height, vec2 uv, vec2 pos){
    float blur = .001;
    vec2 semiWidth = width /2.;
    vec2 semiHeight = height /2.;
    //sides (left & right)
    float edgeL = edge(-semiWidth.x, -semiWidth.x + blur, uv.x +pos.x);
    float edgeR = edge( semiWidth.y,  semiWidth.y - blur, uv.x +pos.x);
    // top & bottom
    float edgeT = edge(semiHeight.x,  semiHeight.x - blur, uv.y +pos.y);
    float edgeB = edge(-semiHeight.y,-semiHeight.y + blur, uv.y +pos.y);

    return edgeR*edgeL*edgeT*edgeB;
}



void main() {
    vec2 uv = (gl_FragCoord.xy / u_resolution.xy)-0.5;
    float t = u_time;
    uv.y *= u_resolution.y/u_resolution.x;
    vec3 draw = vec3(.0);

    vec3 red = vec3(1., .0, .0);
    vec3 green = vec3(0., 1.0, .0);
    vec3 blue = vec3(0., .0, 1.0);
    vec3 yellow = vec3(1., 1.0, .0);
    vec3 pink = vec3(1., .0, 1.0);
    vec3 white = vec3(1., 1.0, 1.0);

    draw += rectShap(vec2(.02), vec2(.02), uv, vec2(-.1*cos(t), -.1*sin(t)))*white;
    draw += rectShap(vec2(.02), vec2(.02), uv, vec2(-.1, .1*sin(t)))*red;

    draw += circleShap(uv, vec2(cos(t) *.1, -.1* sin(t))) * green;
    draw += circleShap(uv, vec2(cos(t) *.3, .0 + .1 * sin(t))) * pink ;
    draw += circleShap(uv, vec2(cos(t) *.2, .0* sin(t))) * blue ;

    //OUTPUT
    gl_FragColor = vec4(draw, 1.0);
}