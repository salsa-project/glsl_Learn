
// length is the distance between the ORIGIN and the PIXEL
float d = length(uv);
/*==============================
            RECTANGLE
===============================*/
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
/*==============================
            CIRCLE
===============================*/
float circleShap(vec2 uv, vec2 pos){
    float radius= .01;
    float d = length(uv.xy + pos.xy);
    float c = smoothstep(radius, radius - .001, d);
    return c;
}