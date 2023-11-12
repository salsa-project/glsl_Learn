precision mediump float;

uniform vec2 u_resolution;

float Circle(vec2 uv, vec2 p, float r, float blur){
    //distance
    float d = length(uv-p); 
    
    float c = smoothstep(r, r-blur, d);
    
    return c;
}


void main(){
    // Normalized pixel coordinates (0 <> 1)
    vec2 uv = gl_FragCoord.xy / u_resolution.xy;
    
    uv -= .5; // -0.5 <> 0.5
    uv.x *= u_resolution.x / u_resolution.y;
    
    vec3 color = vec3(1.0, .0, .0); 
    
    float c = Circle(uv, vec2(.0), .4, .05);
    c -= Circle(uv, vec2(-.13, .2), 0.08, .01);
    c -= Circle(uv, vec2(.13, .2), 0.08, .01);

    color = vec3(1., 1., .0) * c;
    
    
    // Output to screen
    gl_FragColor = vec4(color, 1.0);
}