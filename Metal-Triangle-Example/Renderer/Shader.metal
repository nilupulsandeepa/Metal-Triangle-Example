//
//  Shader.metal
//  Metal-Triangle-Example
//
//  Created by Nilupul Sandeepa on 2021-04-01.
//

#include <metal_stdlib>
using namespace metal;

struct VertexOut {
    float4 pos [[position]];
};

//Setting each vertex to be draw with color
vertex VertexOut vertexFunction (constant float2 *vertices [[buffer(0)]],
                                 uint vertexId [[vertex_id]]) {
    VertexOut vOut;
    vOut.pos = float4(vertices[vertexId].x, vertices[vertexId].y, 0.0, 1.0);
    return vOut;
}

//Return the color at each vertex of triangle
fragment float4 fragmentFunction (VertexOut vIn [[stage_in]]) {
    return float4(0.960, 0.258, 0.925, 1.0);
}
