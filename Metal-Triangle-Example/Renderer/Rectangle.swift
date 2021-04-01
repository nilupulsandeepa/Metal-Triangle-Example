//
//  Rectangle.swift
//  Metal-Triangle-Example
//
//  Created by Nilupul Sandeepa on 2021-04-01.
//  Comments Credit: https://developer.apple.com/documentation/metal
//

import MetalKit

public class Rectangle {
    
    private var mtlDevice: MTLDevice!
    /**
     Triangle vertices converted to normalized device coordinates
     https://developer.apple.com/documentation/metal/using_a_render_pipeline_to_render_primitives
    */
    private var triangleVertexData: [Float2] = [
        Float2(x: -0.5, y: 0.5),
        Float2(x: -0.5, y: -0.5),
        Float2(x: 0.5, y: -0.5),
        Float2(x: 0.5, y: 0.5)
    ]
    
    /**
     Order of vertices
     */
    private var triangleIndexData: [UInt16] = [
        0, 1, 2,
        0, 2, 3
    ]
    
    /**
     MTLBuffers for vertex and index data
     */
    private var triangleVertexBuffer: MTLBuffer!
    private var triangleIndexBuffer: MTLBuffer!
    
    private var rectangleTexture: MTLTexture!
    
    /**
     The MTLRenderPipelineDescriptor object specifies the rendering configuration state used during a rendering pass, including rasterization (such as multisampling), visibility, blending, tessellation, and graphics function state. Use standard allocation and initialization techniques to create a MTLRenderPipelineDescriptor object. A MTLRenderPipelineDescriptor object is later used to create a MTLRenderPipelineState object
     */
    public var renderPipelineState: MTLRenderPipelineState!
    
    init(withDevice device: MTLDevice) {
        self.mtlDevice = device
        self.triangleVertexBuffer = self.mtlDevice.makeBuffer(bytes: self.triangleVertexData, length: MemoryLayout<Float2>.stride * self.triangleVertexData.count, options: [.storageModeShared])
        self.triangleIndexBuffer = self.mtlDevice.makeBuffer(bytes: self.triangleIndexData, length: MemoryLayout<UInt16>.stride * self.triangleIndexData.count, options: [.storageModeShared])
        
        let library: MTLLibrary = self.mtlDevice.makeDefaultLibrary()!
        
        let vertexFunction: MTLFunction = library.makeFunction(name: "vertexFunction")!
        let fragmentFunction: MTLFunction = library.makeFunction(name: "fragmentFunction")!
        
        let renderPipelineDescriptor: MTLRenderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        renderPipelineDescriptor.colorAttachments[0].isBlendingEnabled = true
        renderPipelineDescriptor.colorAttachments[0].alphaBlendOperation = .add
        renderPipelineDescriptor.colorAttachments[0].rgbBlendOperation = .add
        renderPipelineDescriptor.colorAttachments[0].sourceRGBBlendFactor = .sourceAlpha
        renderPipelineDescriptor.colorAttachments[0].sourceAlphaBlendFactor = .one
        renderPipelineDescriptor.colorAttachments[0].destinationRGBBlendFactor = .oneMinusSourceAlpha
        renderPipelineDescriptor.colorAttachments[0].destinationAlphaBlendFactor = .oneMinusSourceAlpha
        
        do {
            self.renderPipelineState = try self.mtlDevice.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            fatalError()
        }
    }
    
    public func draw(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBuffer(self.triangleVertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.setRenderPipelineState(self.renderPipelineState)
        renderCommandEncoder.drawIndexedPrimitives(type: .triangle, indexCount: self.triangleIndexData.count, indexType: .uint16, indexBuffer: self.triangleIndexBuffer, indexBufferOffset: 0)
    }
}

