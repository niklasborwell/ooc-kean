/* This file is part of magic-sdk, an sdk for the open source programming language magic.
 *
 * Copyright (C) 2016 magic-lang
 *
 * This software may be modified and distributed under the terms
 * of the MIT license.  See the LICENSE file for details.
 */

use base
use collections
use geometry
use draw-gpu
use draw
use opengl
use unit

GpuSurfaceTest: class extends Fixture {
	init: func {
		super("GpuSurfaceTest")
		sourceImage := RasterRgba open("test/draw/gpu/input/quad1.png")
		sourceSize := sourceImage size
		this add("draw red quadrant scale 1:1", func {
			correctImage := RasterRgba open("test/draw/gpu/correct/quadrant_red.png")
			gpuImage := gpuContext createRgba(sourceSize)
			gpuImage canvas pen = Pen new(ColorRgba new())
			gpuImage canvas clear()
			quadrantRed := FloatBox2D new(0.0f, 0.0f, 0.5f, 0.5f)
			DrawState new(gpuImage) setInputImage(sourceImage) setSourceNormalized(quadrantRed) setDestinationNormalized(quadrantRed) draw()
			rasterFromGpu := gpuImage toRaster()
			expect(rasterFromGpu distance(correctImage), is equal to(0.0f))
			rasterFromGpu free(); correctImage free(); gpuImage free()
		})
		this add("draw yellow quadrant scale 1:1", func {
			correctImage := RasterRgba open("test/draw/gpu/correct/quadrant_yellow.png")
			gpuImage := gpuContext createRgba(sourceSize)
			gpuImage canvas pen = Pen new(ColorRgba new())
			gpuImage canvas clear()
			quadrantYellow := FloatBox2D new(0.5f, 0.0f, 0.5f, 0.5f)
			DrawState new(gpuImage) setInputImage(sourceImage) setSourceNormalized(quadrantYellow) setDestinationNormalized(quadrantYellow) draw()
			rasterFromGpu := gpuImage toRaster()
			expect(rasterFromGpu distance(correctImage), is equal to(0.0f))
			rasterFromGpu free(); correctImage free(); gpuImage free()
		})
		this add("draw blue quadrant scale 1:1", func {
			correctImage := RasterRgba open("test/draw/gpu/correct/quadrant_blue.png")
			gpuImage := gpuContext createRgba(sourceSize)
			gpuImage canvas pen = Pen new(ColorRgba new())
			gpuImage canvas clear()
			quadrantBlue := FloatBox2D new(0.0f, 0.5f, 0.5f, 0.5f)
			DrawState new(gpuImage) setInputImage(sourceImage) setSourceNormalized(quadrantBlue) setDestinationNormalized(quadrantBlue) draw()
			rasterFromGpu := gpuImage toRaster()
			expect(rasterFromGpu distance(correctImage), is equal to(0.0f))
			rasterFromGpu free(); correctImage free(); gpuImage free()
		})
		this add("draw green quadrant scale 1:1", func {
			correctImage := RasterRgba open("test/draw/gpu/correct/quadrant_green.png")
			gpuImage := gpuContext createRgba(sourceSize)
			gpuImage canvas pen = Pen new(ColorRgba new())
			gpuImage canvas clear()
			quadrantGreen := FloatBox2D new(0.5f, 0.5f, 0.5f, 0.5f)
			DrawState new(gpuImage) setInputImage(sourceImage) setSourceNormalized(quadrantGreen) setDestinationNormalized(quadrantGreen) draw()
			rasterFromGpu := gpuImage toRaster()
			expect(rasterFromGpu distance(correctImage), is equal to(0.0f))
			correctImage free(); rasterFromGpu free(); gpuImage free()
		})
		this add("draw combined quadrants", func {
			quadrantRed := RasterRgba open("test/draw/gpu/correct/quadrant_red.png")
			quadrantYellow := RasterRgba open("test/draw/gpu/correct/quadrant_yellow.png")
			quadrantBlue := RasterRgba open("test/draw/gpu/correct/quadrant_blue.png")
			quadrantGreen := RasterRgba open("test/draw/gpu/correct/quadrant_green.png")
			correctImage := RasterRgba open("test/draw/gpu/correct/quad.png")
			gpuImage := gpuContext createRgba(sourceSize)
			gpuImage canvas clear()
			redBox := FloatBox2D new(0.0f, 0.0f, 0.5f, 0.5f)
			yellowBox := FloatBox2D new(0.5f, 0.0f, 0.5f, 0.5f)
			blueBox := FloatBox2D new(0.0f, 0.5f, 0.5f, 0.5f)
			greenBox := FloatBox2D new(0.5f, 0.5f, 0.5f, 0.5f)
			DrawState new(gpuImage) setInputImage(quadrantRed) setSourceNormalized(redBox) setDestinationNormalized(redBox) draw()
			DrawState new(gpuImage) setInputImage(quadrantYellow) setSourceNormalized(yellowBox) setDestinationNormalized(yellowBox) draw()
			DrawState new(gpuImage) setInputImage(quadrantBlue) setSourceNormalized(blueBox) setDestinationNormalized(blueBox) draw()
			DrawState new(gpuImage) setInputImage(quadrantGreen) setSourceNormalized(greenBox) setDestinationNormalized(greenBox) draw()
			rasterFromGpu := gpuImage toRaster()
			expect(rasterFromGpu distance(correctImage), is equal to(0.0f))
			quadrantRed free(); quadrantYellow free(); quadrantBlue free(); quadrantGreen free()
			correctImage free(); rasterFromGpu free(); gpuImage free()
		})
		this add("draw red quadrant zoomed", func {
			correctImage := RasterRgba open("test/draw/gpu/correct/quadrant_red_zoom.png")
			gpuImage := gpuContext createRgba(sourceSize)
			gpuImage canvas clear()
			redBox := FloatBox2D new(0.0f, 0.0f, 0.5f, 0.5f)
			DrawState new(gpuImage) setInputImage(sourceImage) setSourceNormalized(redBox) draw()
			rasterFromGpu := gpuImage toRaster()
			expect(rasterFromGpu distance(correctImage), is equal to(0.0f))
			correctImage free(); rasterFromGpu free(); gpuImage free()
		})
		this add("draw quad 1:4 scale top left bottom right and 180deg x rotation", func {
			correctImage := RasterRgba open("test/draw/gpu/correct/quad_scaled_top_left_bottom_right_180deg_x_rotation.png")
			gpuImage := gpuContext createRgba(sourceSize)
			gpuImage canvas clear()
			quadrantTopLeft := FloatBox2D new(0.0f, 0.0f, 0.5f, 0.5f)
			quadrantBottomRight := FloatBox2D new(0.5f, 0.5f, 0.5f, 0.5f)
			DrawState new(gpuImage) setInputImage(sourceImage) setDestinationNormalized(quadrantTopLeft) setTransformNormalized(FloatTransform3D createRotationX(180.0f toRadians())) draw()
			DrawState new(gpuImage) setInputImage(sourceImage) setDestinationNormalized(quadrantBottomRight) setTransformNormalized(FloatTransform3D createRotationX(180.0f toRadians())) draw()
			rasterFromGpu := gpuImage toRaster()
			expect(rasterFromGpu distance(correctImage), is equal to(0.0f) within(0.05f))
			correctImage free(); rasterFromGpu free(); gpuImage free()
		})
		this add("draw shapes", func {
			correctImage := RasterMonochrome open("test/draw/gpu/correct/shapes.png")
			gpuImage := gpuContext createMonochrome(sourceSize)
			gpuImage canvas clear()
			trianglePoints := VectorList<FloatPoint2D> new()
			lineLength := 200.0f
			trianglePoints add(FloatPoint2D new(-lineLength, lineLength / 2.0f))
			trianglePoints add(FloatPoint2D new (lineLength, lineLength / 2.0f))
			trianglePoints add(FloatPoint2D new(0.0f, -lineLength))
			trianglePoints add(FloatPoint2D new(-lineLength, lineLength / 2.0f))
			gpuImage canvas drawLines(trianglePoints)
			gpuImage canvas drawBox(FloatBox2D new(-lineLength, -lineLength, lineLength * 2.0f, lineLength * 2.0f))
			//
			// NOTE! The circle use a point size of 1.0f (OpenGLMapPoints in OpenGLMap.ooc)
			//
			theta := 0.0f
			step := Float pi / 20.0f
			origo_x := 0.0f
			origo_y := 0.0f
			radius := lineLength
			circlePoints := VectorList<FloatPoint2D> new()
			while (theta <= 360.0f) {
				circlePoints add(FloatPoint2D new(origo_x + radius * theta cos(), origo_y - radius * theta sin()))
				theta += step
			}
			gpuImage canvas drawPoints(circlePoints)
			rasterFromGpu := gpuImage toRaster()
			expect(rasterFromGpu distance(correctImage), is equal to(0.0f))
		})
	}
}
gpuContext := OpenGLContext new()
GpuSurfaceTest new() run() . free()
gpuContext free()
