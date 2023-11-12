document.addEventListener('DOMContentLoaded', function() {
    // Get the WebGL context
    const canvas = document.getElementById('webgl-canvas');
    const gl = canvas.getContext('webgl');

    // Check if WebGL is available
    if (!gl) {
        console.error('Unable to initialize WebGL. Your browser may not support it.');
        return;
    }

    // Load GLSL code dynamically
    fetch('shader.glsl')
        .then(response => response.text())
        .then(shaderCode => {
            // Compile and link the program
            const program = createProgram(gl, shaderCode);
            gl.useProgram(program);

            // Set resolution uniform
            const resolutionLocation = gl.getUniformLocation(program, 'u_resolution');
            gl.uniform2f(resolutionLocation, canvas.width, canvas.height);

            // Draw a rectangle covering the entire canvas
            const positionBuffer = gl.createBuffer();
            gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer);
            const positions = [
                -1.0, -1.0,
                 1.0, -1.0,
                -1.0,  1.0,
                 1.0,  1.0,
            ];
            gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(positions), gl.STATIC_DRAW);

            const positionAttributeLocation = gl.getAttribLocation(program, 'a_position');
            gl.enableVertexAttribArray(positionAttributeLocation);
            gl.vertexAttribPointer(positionAttributeLocation, 2, gl.FLOAT, false, 0, 0);

            // Draw the rectangle
            gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);
        })
        .catch(error => console.error('Error loading GLSL code:', error));
});

function createShader(gl, type, source) {
    const shader = gl.createShader(type);
    gl.shaderSource(shader, source);
    gl.compileShader(shader);
    const success = gl.getShaderParameter(shader, gl.COMPILE_STATUS);
    if (success) {
        return shader;
    }

    console.error('Shader compilation failed:', gl.getShaderInfoLog(shader));
    gl.deleteShader(shader);
}

function createProgram(gl, fragmentShaderSource) {
    const vertexShaderSource = `
        attribute vec4 a_position;
        void main() {
            gl_Position = a_position;
        }
    `;

    const vertexShader = createShader(gl, gl.VERTEX_SHADER, vertexShaderSource);
    const fragmentShader = createShader(gl, gl.FRAGMENT_SHADER, fragmentShaderSource);

    const program = gl.createProgram();
    gl.attachShader(program, vertexShader);
    gl.attachShader(program, fragmentShader);
    gl.linkProgram(program);

    const success = gl.getProgramParameter(program, gl.LINK_STATUS);
    if (success) {
        return program;
    }

    console.error('Program linking failed:', gl.getProgramInfoLog(program));
    gl.deleteProgram(program);
}
