@Link("cairo")
lib LibCairo
	alias CairoBool = Int32
	type CairoBox = CairoLine
	alias CairoDestroyFunc = (Void* -> Void)
	alias CairoFixed = Int32
	alias CairoSurfaceObserverCallback = (CairoSurface*, CairoSurface*, Void* -> Void)
	alias CairoRecursiveMutexImpl = Int32
	alias CairoRecursiveMutex = CairoRecursiveMutexImpl

	enum CairoContent
		CairoContentColor      =  4096
		CairoContentAlpha      =  8192
		CairoContentColorAlpha = 12288
	end

	enum CairoStatus
		CairoStatusSuccess                 =  0
		CairoStatusNoMemory                =  1
		CairoStatusInvalidRestore          =  2
		CairoStatusInvalidPopGroup         =  3
		CairoStatusNoCurrentPoint          =  4
		CairoStatusInvalidMatrix           =  5
		CairoStatusInvalidStatus           =  6
		CairoStatusNullPointer             =  7
		CairoStatusInvalidString           =  8
		CairoStatusInvalidPathData         =  9
		CairoStatusReadError               = 10
		CairoStatusWriteError              = 11
		CairoStatusSurfaceFinished         = 12
		CairoStatusSurfaceTypeMismatch     = 13
		CairoStatusPatternTypeMismatch     = 14
		CairoStatusInvalidContent          = 15
		CairoStatusInvalidFormat           = 16
		CairoStatusInvalidVisual           = 17
		CairoStatusFileNotFound            = 18
		CairoStatusInvalidDash             = 19
		CairoStatusInvalidDscComment       = 20
		CairoStatusInvalidIndex            = 21
		CairoStatusClipNotRepresentable    = 22
		CairoStatusTempFileError           = 23
		CairoStatusInvalidStride           = 24
		CairoStatusFontTypeMismatch        = 25
		CairoStatusUserFontImmutable       = 26
		CairoStatusUserFontError           = 27
		CairoStatusNegativeCount           = 28
		CairoStatusInvalidClusters         = 29
		CairoStatusInvalidSlant            = 30
		CairoStatusInvalidWeight           = 31
		CairoStatusInvalidSize             = 32
		CairoStatusUserFontNotImplemented  = 33
		CairoStatusDeviceTypeMismatch      = 34
		CairoStatusDeviceError             = 35
		CairoStatusInvalidMeshConstruction = 36
		CairoStatusDeviceFinished          = 37
		CairoStatusJbig2GlobalMissing      = 38
		CairoStatusPngError                = 39
		CairoStatusFreetypeError           = 40
		CairoStatusWin32GdiError           = 41
		CairoStatusTagError                = 42
		CairoStatusLastStatus              = 43
	end

	enum CairoSurfaceObserverMode
		CairoSurfaceObserverNormal           = 0
		CairoSurfaceObserverRecordOperations = 1
	end

	enum CairoFormat
		CairoFormatInvalid  = -1
		CairoFormatArgb32   =  0
		CairoFormatRgb24    =  1
		CairoFormatA8       =  2
		CairoFormatA1       =  3
		CairoFormatRgb16565 =  4
		CairoFormatRgb30    =  5
	end

	enum CairoSubpixelOrder
		CairoSubpixelOrderDefault = 0
		CairoSubpixelOrderRgb     = 1
		CairoSubpixelOrderBgr     = 2
		CairoSubpixelOrderVrgb    = 3
		CairoSubpixelOrderVbgr    = 4
	end

	enum CairoDeviceType
		CairoDeviceTypeDrm     =  0
		CairoDeviceTypeGl      =  1
		CairoDeviceTypeScript  =  2
		CairoDeviceTypeXcb     =  3
		CairoDeviceTypeXlib    =  4
		CairoDeviceTypeXml     =  5
		CairoDeviceTypeCogl    =  6
		CairoDeviceTypeWin32   =  7
		CairoDeviceTypeInvalid = -1
	end

	struct CairoPoint
		x : CairoFixed
		y : CairoFixed
	end

	struct CairoPointDouble
		x : Double
		y : Double
	end

	struct CairoPointInt
		x : Int32
		y : Int32
	end

	struct CairoLine
		p1 : CairoPoint
		p2 : CairoPoint
	end

	struct CairoDeviceBackend
		type : CairoDeviceType
		lock : (Void* -> Void)
		unlock : (Void* -> Void)
		flush : (Void* -> CairoStatus)
		finish : (Void* -> Void)
		destroy : (Void* -> Void)
	end

	struct CairoDevice
		ref_count : CairoReferenceCount
		status : CairoStatus
		user_data : CairoUserDataArray
		backend : CairoDeviceBackend*
		mutex : CairoRecursiveMutex
		mutex_depth : UInt32
		finished : CairoBool
	end

	struct CairoDamage
		status : CairoStatus
		region : CairoRegion*
		dirty : Int32
		remain : Int32
		chunks : CairoDamageChunk
		tail : CairoDamageChunk*
		boxes : CairoBoxT[32]
	end

	struct CairoDamageChunk
		_next : CairoDamageChunk*
		base : CairoBox*
		count : Int32
		size : Int32
	end


	struct CairoSurface
		backend : CairoSurfaceBackend*
		device : CairoDevice*
		type : CairoSurfaceType
		content : CairoContent
		ref_count : CairoReferenceCount
		status : CairoStatus
		unique_id : UInt32
		serial : UInt32
		damage : CairoDamage*
		_finishing : UInt32
		finished : UInt32
		is_clear : UInt32
		has_font_options : UInt32
		owns_device : UInt32
		is_vector : UInt32
		user_data : CairoUserDataArray
		mime_data : CairoUserDataArray
		device_transform : CairoMatrix
		device_transform_inverse : CairoMatrix
		device_transform_observers : CairoList
		x_resolution : Double
		y_resolution : Double
		x_fallback_resolution : Double
		y_fallback_resolution : Double
		snapshot_of : CairoSurface*
		snapshot_detach : CairoSurfaceFunc
		snapshots : CairoList
		snapshot : CairoList
		font_options : CairoFontOptions
	end

	struct CairoList
		_next : CairoList*
		prev : CairoList*
	end

	enum CairoHintMetrics
		CairoHintMetricsDefault = 0
		CairoHintMetricsOff     = 1
		CairoHintMetricsOn      = 2
	end

	enum CairoHintStyle
		CairoHintStyleDefault = 0
		CairoHintStyleNone    = 1
		CairoHintStyleSlight  = 2
		CairoHintStyleMedium  = 3
		CairoHintStyleFull    = 4
	end

	struct CairoFontOptions
		antialias : CairoAntialias
		subpixel_order : CairoSubpixelOrder
		lcd_filter : CairoLcdFilter
		hint_style : CairoHintStyle
		hint_metrics : CairoHintMetrics
		round_glyph_positions : CairoRoundGlyphPositions
		variations : Char*
	end

	struct CairoRectangle
		x : Double
		y : Double
		width : Double
		height : Double
	end

	struct CairoRectangleInt
		x : Int32
		y : Int32
		width : Int32
		height : Int32
	end

	struct CairoRectangleList
		status : CairoStatus
		rectangles : CairoRectangle*
		num_rectangles : Int32
	end

	struct CairoMatrix
		xx : Double
		yx : Double
		xy : Double
		yy : Double
		x0 : Double
		y0 : Double
	end

	struct CairoReferenceCount
		ref_count : CairoAtomicInt
	end

	enum CairoExtend
		CairoExtendNone    = 0
		CairoExtendRepeat  = 1
		CairoExtendReflect = 2
		CairoExtendPad     = 3
	end

	enum CairoFilter
		CairoFilterFast     = 0
		CairoFilterGood     = 1
		CairoFilterBest     = 2
		CairoFilterNearest  = 3
		CairoFilterBilinear = 4
		CairoFilterGaussian = 5
	end

	enum CairoPatternType
		CairoPatternTypeSolid        = 0
		CairoPatternTypeSurface      = 1
		CairoPatternTypeLinear       = 2
		CairoPatternTypeRadial       = 3
		CairoPatternTypeMesh         = 4
		CairoPatternTypeRasterSource = 5
	end

	struct CairoPattern
		ref_count : CairoReferenceCount
		status : CairoStatus
		user_data : CairoUserDataArray
		observers : CairoList
		type : CairoPatternType
		filter : CairoFilter
		extend_ : CairoExtend
		has_component_alpha : CairoBool
		matrix : CairoMatrix
		opacity : Double
	end

	struct CairoUserDataKey
		unused : Int32
	end

	enum CairoHintMetrics
		CairoHintMetricsDefault = 0
		CairoHintMetricsOff     = 1
		CairoHintMetricsOn      = 2
	end

	enum CairoLcdFilter
		CairoLcdFilterDefault    = 0
		CairoLcdFilterNone       = 1
		CairoLcdFilterIntraPixel = 2
		CairoLcdFilterFir3       = 3
		CairoLcdFilterFir5       = 4
	end

	enum CairoAntialias
		CairoAntialiasDefault  = 0
		CairoAntialiasNone     = 1
		CairoAntialiasGray     = 2
		CairoAntialiasSubpixel = 3
		CairoAntialiasFast     = 4
		CairoAntialiasGood     = 5
		CairoAntialiasBest     = 6
	end

	enum CairoRoundGlyphPositions
		CairoRoundGlyphPosDefault = 0
		CairoRoundGlyphPosOn      = 1
		CairoRoundGlyphPosOff     = 2
	end

	struct CairoFontOptions
		antialias : CairoAntialias
		subpixel_order : CairoSubpixelOrder
		lcd_filter : CairoLcdFilter
		hint_style : CairoHintStyle
		hint_metrics : CairoHintMetrics
		round_glyph_positions : CairoRoundGlyphPositions
		variations : Char*
	end

	fun cairo_create : Cairo*
		fun cairo_create(target : CairoSurface*) : Cairo*
		fun cairo_status : CairoStatus
	fun cairo_status(cr : Cairo*) : CairoStatus
	fun cairo_status_to_string(status : CairoStatus) : Char*
		fun cairo_surface_copy_page
	fun cairo_surface_copy_page(surface : CairoSurface*)
	fun cairo_surface_create_for_rectangle(target : CairoSurface*, x : Double, y : Double, width : Double, height : Double) : CairoSurface*
		fun cairo_surface_create_observer(target : CairoSurface*, mode : CairoSurfaceObserverMode) : CairoSurface*
		fun cairo_surface_create_similar(other : CairoSurface*, content : CairoContent, width : Int32, height : Int32) : CairoSurface*
		fun cairo_surface_create_similar_image : CairoSurface*
		fun cairo_surface_create_similar_image(other : CairoSurface*, format : CairoFormat, width : Int32, height : Int32) : CairoSurface*
		fun cairo_surface_destroy
	fun cairo_surface_destroy(surface : CairoSurface*)
	fun cairo_surface_finish
	fun cairo_surface_finish(surface : CairoSurface*)
	fun cairo_surface_flush
	fun cairo_surface_flush(surface : CairoSurface*)
	fun cairo_surface_get_content(surface : CairoSurface*) : CairoContent
	fun cairo_surface_get_device(surface : CairoSurface*) : CairoDevice*
		fun cairo_surface_get_device_offset
	fun cairo_surface_get_device_offset(surface : CairoSurface*, x_offset : Double*, y_offset : Double*)
	fun cairo_surface_get_device_scale
	fun cairo_surface_get_device_scale(surface : CairoSurface*, x_scale : Double*, y_scale : Double*)
	fun cairo_surface_get_fallback_resolution(surface : CairoSurface*, x_pixels_per_inch : Double*, y_pixels_per_inch : Double*)
	fun cairo_surface_get_font_options
	fun cairo_surface_get_font_options(surface : CairoSurface*, options : CairoFontOptions*)
	fun cairo_surface_get_mime_data
	fun cairo_surface_get_mime_data(surface : CairoSurface*, mime_type : Char*, data : UInt8**, length : LibC::ULong*)
	fun cairo_surface_get_reference_count(surface : CairoSurface*) : UInt32
	fun cairo_surface_get_type(surface : CairoSurface*) : CairoSurfaceType
	fun cairo_surface_get_user_data(surface : CairoSurface*, key : CairoUserDataKey*) : Void*
		fun cairo_surface_has_show_text_glyphs : CairoBool
	fun cairo_surface_has_show_text_glyphs(surface : CairoSurface*) : CairoBool
	fun cairo_surface_map_to_image(surface : CairoSurface*, extents : CairoRectangleInt*) : CairoSurface*
		fun cairo_surface_mark_dirty
	fun cairo_surface_mark_dirty(surface : CairoSurface*)
	fun cairo_surface_mark_dirty_rectangle
	fun cairo_surface_mark_dirty_rectangle(surface : CairoSurface*, x : Int32, y : Int32, width : Int32, height : Int32)
	fun cairo_surface_observer_add_fill_callback(abstract_surface : CairoSurface*, func : CairoSurfaceObserverCallback, data : Void*) : CairoStatus
	fun cairo_surface_observer_add_finish_callback(abstract_surface : CairoSurface*, func : CairoSurfaceObserverCallback, data : Void*) : CairoStatus
	fun cairo_surface_observer_add_flush_callback(abstract_surface : CairoSurface*, func : CairoSurfaceObserverCallback, data : Void*) : CairoStatus
	fun cairo_surface_observer_add_glyphs_callback(abstract_surface : CairoSurface*, func : CairoSurfaceObserverCallback, data : Void*) : CairoStatus
	fun cairo_surface_observer_add_mask_callback(abstract_surface : CairoSurface*, func : CairoSurfaceObserverCallback, data : Void*) : CairoStatus
	fun cairo_surface_observer_add_paint_callback(abstract_surface : CairoSurface*, func : CairoSurfaceObserverCallback, data : Void*) : CairoStatus
	fun cairo_surface_observer_add_stroke_callback(abstract_surface : CairoSurface*, func : CairoSurfaceObserverCallback, data : Void*) : CairoStatus
	fun cairo_surface_observer_elapsed(surface : CairoSurface*) : Double
	fun cairo_surface_observer_print(surface : CairoSurface*, write_func : CairoWriteFunc, closure : Void*) : CairoStatus
	fun cairo_surface_reference : CairoSurface*
		fun cairo_surface_reference(surface : CairoSurface*) : CairoSurface*
		fun cairo_surface_set_device_offset
	fun cairo_surface_set_device_offset(surface : CairoSurface*, x_offset : Double, y_offset : Double)
	fun cairo_surface_set_device_scale
	fun cairo_surface_set_device_scale(surface : CairoSurface*, x_scale : Double, y_scale : Double)
	fun cairo_surface_set_fallback_resolution
	fun cairo_surface_set_fallback_resolution(surface : CairoSurface*, x_pixels_per_inch : Double, y_pixels_per_inch : Double)
	fun cairo_surface_set_mime_data : CairoStatus
	fun cairo_surface_set_mime_data(surface : CairoSurface*, mime_type : Char*, data : UInt8*, length : LibC::ULong, destroy : CairoDestroyFunc, closure : Void*) : CairoStatus
	fun cairo_surface_set_user_data(surface : CairoSurface*, key : CairoUserDataKey*, user_data : Void*, destroy : CairoDestroyFunc) : CairoStatus
	fun cairo_surface_show_page
	fun cairo_surface_show_page(surface : CairoSurface*)
	fun cairo_surface_status : CairoStatus
	fun cairo_surface_status(surface : CairoSurface*) : CairoStatus
	fun cairo_surface_supports_mime_type : CairoBool
	fun cairo_surface_supports_mime_type(surface : CairoSurface*, mime_type : Char*) : CairoBool
	fun cairo_surface_unmap_image(surface : CairoSurface*, image : CairoSurface*)
	fun cairo_transform
	fun cairo_transform(cr : Cairo*, matrix : CairoMatrix*)
	fun cairo_translate
	fun cairo_translate(cr : Cairo*, tx : Double, ty : Double)
	fun cairo_set_operator
	fun cairo_set_operator(cr : Cairo*, op : CairoOperator)
	fun cairo_restore
	fun cairo_restore(cr : Cairo*)
	fun cairo_rotate(cr : Cairo*, angle : Double)
	fun cairo_save
	fun cairo_save(cr : Cairo*)
	fun cairo_scale
	fun cairo_scale(cr : Cairo*, sx : Double, sy : Double)
	fun cairo_set_source
	fun cairo_set_source(cr : Cairo*, source : CairoPattern*)
	fun cairo_set_source_rgb
	fun cairo_set_source_rgb(cr : Cairo*, red : Double, green : Double, blue : Double)
	fun cairo_set_source_rgba(cr : Cairo*, red : Double, green : Double, blue : Double, alpha : Double)
	fun cairo_set_source_surface
	fun cairo_set_source_surface(cr : Cairo*, surface : CairoSurface*, x : Double, y : Double)
end
