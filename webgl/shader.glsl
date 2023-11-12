precision mediump float;

uniform vec2 u_resolution;

void main() {
    // Convert the pixel coordinates to the range [-0.5, 0.5]
    vec2 uv = (gl_FragCoord.xy / u_resolution.xy) - 0.5;
    uv.y *= u_resolution.y / u_resolution.x;

    // Create a rectangle
    float insideRectangle = step(-0.4, uv.x) *
                            step(-0.4, -uv.x) *
                            step(-0.4, uv.y) *
                            step(-0.4, -uv.y);

    // Output color
    gl_FragColor = vec4(1.0, 0.0, 0.0, insideRectangle);
}
