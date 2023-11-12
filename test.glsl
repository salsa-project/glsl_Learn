precision mediump float;

uniform vec2 u_resolution;

float circleShape(vec2 uv, vec2 p, float r, float blur) {
    float d = length(uv - p);
    float c = smoothstep(r, r - blur, d);
    return c;
}

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution.xy;
    
    uv -= 0.5; // -0.5 <> 0.5

    uv.y *= u_resolution.y/u_resolution.x;


    vec3 color;

    // Set color for the main circle to yellow
    float mainCircle = circleShape(uv, vec2(0), 0.3, 0.01);
    color = vec3(1.0, 1.0, 0.0) * mainCircle;

    // Set color for the first subtracted circle to red
    float subtractedCircle1 = circleShape(uv, vec2(0.1), 0.08, 0.05);
    color -= vec3(0.0, 1.0, 0.0) * subtractedCircle1;

    // Set color for the second subtracted circle to red
    float subtractedCircle2 = circleShape(uv, vec2(-0.1, 0.1), 0.08, 0.05);
    color -= vec3(0.0, 1.0, 0.0) * subtractedCircle2;

    // Clamp color values to ensure they are not greater than 1.0
    color = clamp(color, 0.0, 1.0);

    // Output
    gl_FragColor = vec4(color, 1.0);
}
