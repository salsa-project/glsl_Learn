precision mediump float;

uniform vec2 u_resolution;
uniform float u_time;

float edge(float start, float end, float axie){
    float e = smoothstep(start, end, axie);
    return e;
}

float rect(vec2 width, vec2 height, float blur, vec2 uv){
    vec2 semiWidth = width /2.;
    vec2 semiHeight = height /2.;
    //sides (left & right)
    float edgeL = edge(-semiWidth.x, -semiWidth.x + blur, uv.x);
    float edgeR = edge( semiWidth.y,  semiWidth.y - blur, uv.x);
    // top & bottom
    float edgeT = edge(semiHeight.x,  semiHeight.x - blur, uv.y);
    float edgeB = edge(-semiHeight.y,-semiHeight.y + blur, uv.y);

    return edgeR*edgeL*edgeT*edgeB;
}

void main() {
    vec2 uv = (gl_FragCoord.xy / u_resolution.xy)-0.5;
    float t = u_time;
    uv.y *= u_resolution.y/u_resolution.x; 
    vec3 color = vec3(1., 1., .0); 


    float m = sin((t*5.)+uv.x * 8.) * .1;
    uv.y = uv.y-m;    

    
    float line = rect(vec2(0.85), vec2(0.02), 0.01, uv);
    color *= line;

    gl_FragColor = vec4(color, 1.0);
}