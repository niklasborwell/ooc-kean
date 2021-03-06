/* This file is part of magic-sdk, an sdk for the open source programming language magic.
 *
 * Copyright (C) 2016 magic-lang
 *
 * This software may be modified and distributed under the terms
 * of the MIT license.  See the LICENSE file for details.
 */

use base
use geometry
use draw-gpu
use draw
use opengl
use unit

GpuImageReflectionTest: class extends Fixture {
	init: func {
		super("GpuImageReflectionTest")
		sourceImage := RasterRgba open("test/draw/gpu/input/Flower.png")
		this add("GPU reflection X (RGBA)", func {
			correctImage := RasterRgba open("test/draw/gpu/correct/reflection_rgba_X.png")
			gpuImage := gpuContext createRgba(sourceImage size)
			gpuImage canvas clear()
			DrawState new(gpuImage) setTransformNormalized(FloatTransform3D createReflectionX()) setInputImage(sourceImage) draw()
			rasterFromGpu := gpuImage toRaster()
			expect(rasterFromGpu distance(correctImage), is equal to(0.0f))
		})
		this add("GPU reflection Y (RGBA)", func {
			correctImage := RasterRgba open("test/draw/gpu/correct/reflection_rgba_Y.png")
			gpuImage := gpuContext createRgba(sourceImage size)
			gpuImage canvas clear()
			DrawState new(gpuImage) setTransformNormalized(FloatTransform3D createReflectionY()) setInputImage(sourceImage) draw()
			rasterFromGpu := gpuImage toRaster()
			expect(rasterFromGpu distance(correctImage), is equal to(0.0f))
		})
		this add("GPU reflection Z (RGBA)", func {
			correctImage := RasterRgba open("test/draw/gpu/correct/reflection_rgba_Z.png")
			gpuImage := gpuContext createRgba(sourceImage size)
			gpuImage canvas clear()
			DrawState new(gpuImage) setTransformNormalized(FloatTransform3D createReflectionZ()) setInputImage(sourceImage) draw()
			rasterFromGpu := gpuImage toRaster()
			expect(rasterFromGpu distance(correctImage), is equal to(0.0f))
		})
	}
}

gpuContext := OpenGLContext new()
GpuImageReflectionTest new() run() . free()
gpuContext free()
