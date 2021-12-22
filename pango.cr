@[Link("pango-1.0")
	lib Pango
		type GData = Void*
			type Cairo = Void*
			type CairoFontOptions = Void*
			type PangoContext = Void*
			alias PangoCairoShapeRendererFunc = (Cairo, PangoAttrShape*, Bool, Void -> Void)
		type CairoFontOptions = Void*
			type PangoCairoFont = Void*
			type PangoCairoFontMap = Void*
			type CairoScaledFont = Void*
			type PangoCairoFont = Void*
			type PangoCairoFontMap = Void*
			type PangoFontDescription = Void*
			type PangoTabArray = Void*
			type PangoLanguage = Void*
			type PangoLayoutIter = Void*
			alias PangoLayoutRun = PangoGlyphItem
		type HbFaceT = Void*
			type HbFontT = Void*
			enum CairoFontType
				CairoFontTypeoy    = 0
				CairoFontTypeFt     = 1
				CairoFontTypeWin32  = 2
				CairoFontTypeQuartz = 3
				CairoFontTypeUser   = 4
		end
		enum PangoAlignment
			PangoAlignLeft   = 0
			PangoAlignCenter = 1
			PangoAlignRight  = 2
		end
		enum PangoGravity
			PangoGravitySouth = 0
			PangoGravityEast  = 1
			PangoGravityNorth = 2
			PangoGravityWest  = 3
			PangoGravityAuto  = 4
		end
		enum PangoFontMask
			PangoFontMaskFamily     =   1
			PangoFontMaskStyle      =   2
			PangoFontMaskVariant    =   4
			PangoFontMaskWeight     =   8
			PangoFontMaskStretch    =  16
			PangoFontMaskSize       =  32
			PangoFontMaskGravity    =  64
			PangoFontMaskVariations = 128
		end

		enum PangoFontScale
			PangoFontScaleNone        = 0
			PangoFontScaleSuperscript = 1
			PangoFontScaleSubscript   = 2
			PangoFontScaleSmallCaps   = 3
		end
		enum PangoVariant
			PangoVariantNormal        = 0
			PangoVariantSmallCaps     = 1
			PangoVariantAllSmallCaps  = 2
			PangoVariantPetiteCaps    = 3
			PangoVariantAllPetiteCaps = 4
			PangoVariantUnicase       = 5
			PangoVariantTitleCaps     = 6
		end
		enum PangoWeight
			PangoWeightThin       =  100
			PangoWeightUltralight =  200
			PangoWeightLight      =  300
			PangoWeightSemilight  =  350
			PangoWeightBook       =  380
			PangoWeightNormal     =  400
			PangoWeightMedium     =  500
			PangoWeightSemibold   =  600
			PangoWeightBold       =  700
			PangoWeightUltrabold  =  800
			PangoWeightHeavy      =  900
			PangoWeightUltraheavy = 1000
		end
		enum PangoStyle
			PangoStyleNormal  = 0
			PangoStyleOblique = 1
			PangoStyleItalic  = 2
		end
		enum PangoStretch
			PangoStretchUltraCondensed = 0
			PangoStretchExtraCondensed = 1
			PangoStretchCondensed      = 2
			PangoStretchSemiCondensed  = 3
			PangoStretchNormal         = 4
			PangoStretchSemiExpanded   = 5
			PangoStretchExpanded       = 6
			PangoStretchExtraExpanded  = 7
			PangoStretchUltraExpanded  = 8
		end
		enum PangoLayoutSerializeFlags
			PangoLayoutSerializeDefault = 0
			PangoLayoutSerializeContext = 1
			PangoLayoutSerializeOutput  = 2
		end
		enum PangoEllipsizeMode
			PangoEllipsizeNone   = 0
			PangoEllipsizeStart  = 1
			PangoEllipsizeMiddle = 2
			PangoEllipsizeEnd    = 3
		end
		struct GError
			domain : UInt32
			code : Int32
			message : Char*
		end
		struct GTypeClass
			g_type : UInt64
		end
		struct GTypeInstance
			g_class : GTypeClass*
		end
		struct GObject
			g_type_instance : GTypeInstance
			ref_count : UInt32
			qdata : GData
		end
		struct GsList
			data : Void*
			next : GsList*
		end
		struct PangoRectangle
			x : Int32
			y : Int32
			width : Int32
			height : Int32
		end
		struct PangoGlyphVisAttr
			is_cluster_start : UInt32
			is_color : UInt32
		end
		struct PangoGlyphGeometry
			width : Int32
			x_offset : Int32
			y_offset : Int32
		end
		struct PangoGlyphInfo
			glyph : PangoGlyph
			geometry : PangoGlyphGeometry
			attr : PangoGlyphVisAttr
		end
		struct PangoGlyphString
			num_glyphs : Int32
			glyphs : PangoGlyphInfo*
			log_clusters : Int32*
			space : Int32
		end
		struct PangoLayoutLine
			layout : PangoLayout
			start_index : Int32
			length : Int32
			runs : GsList*
			is_paragraph_start : UInt32
			resolved_dir : UInt32
		end

		struct PangoLogAttr
			is_line_break : UInt32
			is_mandatory_break : UInt32
			is_char_break : UInt32
			is_white : UInt32
			is_cursor_position : UInt32
			is_word_start : UInt32
			is_word_end : UInt32
			is_sentence_boundary : UInt32
			is_sentence_start : UInt32
			is_sentence_end : UInt32
			backspace_deletes_character : UInt32
			is_expandable_space : UInt32
			is_word_boundary : UInt32
			break_inserts_hyphen : UInt32
			break_removes_preceding : UInt32
			reserved : UInt32
		end
		struct PangoFont
			parent_instance : GObject
		end
		struct PangoFontFace
			parent_instance : GObject
		end
		struct PangoFontFamily
			parent_instance : GObject
		end
		struct PangoFontMap
			parent_instance : GObject
		end

		struct PangoEngine
			parent_instance : GObject
		end 
		struct PangoEngineShape
			parent_instance : PangoEngine
		end
		struct PangoEngineLang
			parent_instance : PangoEngine
		end
		struct PangoAnalysis
			shape_engine : PangoEngineShape*
			lang_engine : PangoEngineLang*
			font : PangoFont*
			level : UInt8
			gravity : UInt8
			flags : UInt8
			script : UInt8
			language : PangoLanguage
			extra_attrs : GsList*
		end
		struct PangoItem
			offset : Int32
			length : Int32
			num_chars : Int32
			analysis : PangoAnalysis
		end
		struct PangoGlyphString
			num_glyphs : Int32
			glyphs : PangoGlyphInfo*
			log_clusters : Int32*
			space : Int32
		end
		struct PangoGlyphItem
			item : PangoItem*
			glyphs : PangoGlyphString*
			y_offset : Int32
			start_x_offset : Int32
			end_x_offset : Int32
		end
		struct PangoFontMetrics
			ref_count : UInt32
			ascent : Int32
			descent : Int32
			height : Int32
			approximate_char_width : Int32
			approximate_digit_width : Int32
			underline_position : Int32
			underline_thickness : Int32
			strikethrough_position : Int32
			strikethrough_thickness : Int32
		end
		struct PangoFontset
			parent_instance : GObject
		end
		struct HbFeatureT
			tag : UInt32
			value : UInt32
			start : UInt32
			_end : UInt32
		end
		fun pango_cairo_context_get_font_options(context : PangoContext) : CairoFontOptions
		fun pango_cairo_context_get_resolution(context : PangoContext) : Int64
		fun pango_cairo_context_get_shape_renderer(context : PangoContext, data : Void*) : PangoCairoShapeRendererFunc
		fun pango_cairo_context_set_font_options(context : PangoContext, options : CairoFontOptions)
		fun pango_cairo_context_set_resolution(context : PangoContext, dpi : Int64)
		fun pango_cairo_context_set_shape_renderer(context : PangoContext, func : PangoCairoShapeRendererFunc, data : Void, dnotify : GDestroyNotify)
		fun pango_cairo_create_context(cr : Cairo) : PangoContext
		fun pango_cairo_create_layout(cr : Cairo) : PangoLayout
		fun pango_cairo_error_underline_path(cr : Cairo, x : Int64, y : Int64, width : Int64, height : Int64)
		fun pango_cairo_font_get_scaled_font(font : PangoCairoFont) : CairoScaledFont
		fun pango_cairo_font_get_type : UInt64
		fun pango_cairo_font_map_create_context(fontmap : PangoCairoFontMap) : PangoContext
		fun pango_cairo_font_map_get_default : PangoFontMap*
			fun pango_cairo_font_map_get_font_type(fontmap : PangoCairoFontMap) : CairoFontType
		fun pango_cairo_font_map_get_resolution(fontmap : PangoCairoFontMap) : Int64
		fun pango_cairo_font_map_get_type : UInt64
		fun pango_cairo_font_map_new : PangoFontMap*
			fun pango_cairo_font_map_new_for_font_type(fonttype : CairoFontType) : PangoFontMap*
			fun pango_cairo_font_map_set_default(fontmap : PangoCairoFontMap)
		fun pango_cairo_font_map_set_resolution(fontmap : PangoCairoFontMap, dpi : Int64)
		fun pango_cairo_glyph_string_path(cr : Cairo, font : PangoFont*, glyphs : PangoGlyphString*)
		fun pango_cairo_layout_line_path(cr : Cairo, line : PangoLayoutLine*)
		fun pango_cairo_layout_path(cr : Cairo, layout : PangoLayout)
		fun pango_cairo_show_error_underline(cr : Cairo, x : Int64, y : Int64, width : Int64, height : Int64)
		fun pango_cairo_show_glyph_item(cr : Cairo, text : Char*, glyph_item : PangoGlyphItem*)
		fun pango_cairo_show_glyph_string(cr : Cairo, font : PangoFont*, glyphs : PangoGlyphString*)
		fun pango_cairo_show_layout(cr : Cairo, layout : PangoLayout)
		fun pango_cairo_show_layout_line(cr : Cairo, line : PangoLayoutLine*)
		fun pango_cairo_update_context(cr : Cairo, context : PangoContext)
		fun pango_cairo_update_layout(cr : Cairo, layout : PangoLayout)
		fun pango_font_describe(font : PangoFont*) : PangoFontDescription
		fun pango_font_describe_with_absolute_size(font : PangoFont*) : PangoFontDescription
		fun pango_font_description_better_match(desc : PangoFontDescription, old_match : PangoFontDescription, new_match : PangoFontDescription) : Bool
		fun pango_font_description_copy(desc : PangoFontDescription) : PangoFontDescription
		fun pango_font_description_copy_static(desc : PangoFontDescription) : PangoFontDescription
		fun pango_font_description_equal(desc1 : PangoFontDescription, desc2 : PangoFontDescription) : Bool
		fun pango_font_description_free(desc : PangoFontDescription)
		fun pango_font_description_from_string(str : Char*) : PangoFontDescription
		fun pango_font_description_get_family(desc : PangoFontDescription) : Char*
			fun pango_font_description_get_gravity(desc : PangoFontDescription) : PangoGravity
		fun pango_font_description_get_set_fields(desc : PangoFontDescription) : PangoFontMask
		fun pango_font_description_get_size(desc : PangoFontDescription) : Int32
		fun pango_font_description_get_size_is_absolute(desc : PangoFontDescription) : Bool
		fun pango_font_description_get_stretch(desc : PangoFontDescription) : PangoStretch
		fun pango_font_description_get_style(desc : PangoFontDescription) : PangoStyle
		fun pango_font_description_get_type : UInt64
		fun pango_font_description_get_variant(desc : PangoFontDescription) : PangoVariant
		fun pango_font_description_get_variations(desc : PangoFontDescription) : Char*
			fun pango_font_description_get_weight(desc : PangoFontDescription) : PangoWeight
		fun pango_font_description_hash(desc : PangoFontDescription) : UInt32
		fun pango_font_description_merge(desc : PangoFontDescription, desc_to_merge : PangoFontDescription, replace_existing : Bool)
		fun pango_font_description_merge_static(desc : PangoFontDescription, desc_to_merge : PangoFontDescription, replace_existing : Bool)
		fun pango_font_description_new : PangoFontDescription
		fun pango_font_description_set_absolute_size(desc : PangoFontDescription, size : Int64)
		fun pango_font_description_set_family(desc : PangoFontDescription, family : Char*)
		fun pango_font_description_set_family_static(desc : PangoFontDescription, family : Char*)
		fun pango_font_description_set_gravity(desc : PangoFontDescription, gravity : PangoGravity)
		fun pango_font_description_set_size(desc : PangoFontDescription, size : Int32)
		fun pango_font_description_set_stretch(desc : PangoFontDescription, stretch : PangoStretch)
		fun pango_font_description_set_style(desc : PangoFontDescription, style : PangoStyle)
		fun pango_font_description_set_variant(desc : PangoFontDescription, variant : PangoVariant)
		fun pango_font_description_set_variations(desc : PangoFontDescription, variations : Char*)
		fun pango_font_description_set_variations_static(desc : PangoFontDescription, variations : Char*)
		fun pango_font_description_set_weight(desc : PangoFontDescription, weight : PangoWeight)
		fun pango_font_description_to_filename(desc : PangoFontDescription) : Char*
			fun pango_font_description_to_string(desc : PangoFontDescription) : Char*
			fun pango_font_description_unset_fields(desc : PangoFontDescription, to_unset : PangoFontMask)
		fun pango_font_descriptions_free(descs : PangoFontDescription*, n_descs : Int32)
		fun pango_font_deserialize(context : PangoContext, bytes : Void*, error : GError**) : PangoFont*
			fun pango_font_face_describe(face : PangoFontFace*) : PangoFontDescription
		fun pango_font_face_get_face_name(face : PangoFontFace*) : Char*
			fun pango_font_face_get_family(face : PangoFontFace*) : PangoFontFamily*
			fun pango_font_face_get_type : UInt64
		fun pango_font_face_is_synthesized(face : PangoFontFace*) : Bool
		fun pango_font_face_list_sizes(face : PangoFontFace*, sizes : Int32**, n_sizes : Int32*)
		fun pango_font_family_get_face(family : PangoFontFamily*, name : Char*) : PangoFontFace*
			fun pango_font_family_get_name(family : PangoFontFamily*) : Char*
			fun pango_font_family_get_type : UInt64
		fun pango_font_family_is_monospace(family : PangoFontFamily*) : Bool
		fun pango_font_family_is_variable(family : PangoFontFamily*) : Bool
		fun pango_font_family_list_faces(family : PangoFontFamily*, faces : PangoFontFace***, n_faces : Int32*)
		fun pango_font_find_shaper(font : PangoFont*, language : PangoLanguage, ch : UInt3232) : PangoEngineShape*
			fun pango_font_get_coverage(font : PangoFont*, language : PangoLanguage) : PangoCoverage
		fun pango_font_get_face(font : PangoFont*) : PangoFontFace*
			fun pango_font_get_features(font : PangoFont*, features : HbFeatureT*, len : UInt32, num_features : UInt32*)
		fun pango_font_get_font_map(font : PangoFont*) : PangoFontMap*
			fun pango_font_get_glyph_extents(font : PangoFont*, glyph : PangoGlyph, ink_rect : PangoRectangle*, logical_rect : PangoRectangle*)
		fun pango_font_get_hb_font(font : PangoFont*) : HbFontT
		fun pango_font_get_languages(font : PangoFont*) : PangoLanguage*
			fun pango_font_get_metrics(font : PangoFont*, language : PangoLanguage) : PangoFontMetrics*
			fun pango_font_get_type : UInt64
		fun pango_font_has_char(font : PangoFont*, wc : UInt32) : Bool
		fun pango_font_map_changed(fontmap : PangoFontMap*)
		fun pango_font_map_create_context(fontmap : PangoFontMap*) : PangoContext
		fun pango_font_map_get_family(fontmap : PangoFontMap*, name : Char*) : PangoFontFamily*
			fun pango_font_map_get_serial(fontmap : PangoFontMap*) : UInt32
		fun pango_font_map_get_type : UInt64
		fun pango_font_map_list_families(fontmap : PangoFontMap*, families : PangoFontFamily***, n_families : Int32*)
		fun pango_font_map_load_font(fontmap : PangoFontMap*, context : PangoContext, desc : PangoFontDescription) : PangoFont*
			fun pango_font_map_load_fontset(fontmap : PangoFontMap*, context : PangoContext, desc : PangoFontDescription, language : PangoLanguage) : PangoFontset*
			fun pango_font_mask_get_type : UInt64
		fun pango_font_metrics_get_approximate_char_width(metrics : PangoFontMetrics*) : Int32
		fun pango_font_metrics_get_approximate_digit_width(metrics : PangoFontMetrics*) : Int32
		fun pango_font_metrics_get_ascent(metrics : PangoFontMetrics*) : Int32
		fun pango_font_metrics_get_descent(metrics : PangoFontMetrics*) : Int32
		fun pango_font_metrics_get_height(metrics : PangoFontMetrics*) : Int32
		fun pango_font_metrics_get_strikethrough_position(metrics : PangoFontMetrics*) : Int32
		fun pango_font_metrics_get_strikethrough_thickness(metrics : PangoFontMetrics*) : Int32
		fun pango_font_metrics_get_type : UInt64
		fun pango_font_metrics_get_underline_position(metrics : PangoFontMetrics*) : Int32
		fun pango_font_metrics_get_underline_thickness(metrics : PangoFontMetrics*) : Int32
		fun pango_font_metrics_ref(metrics : PangoFontMetrics*) : PangoFontMetrics*
			fun pango_font_metrics_unref(metrics : PangoFontMetrics*)
		fun pango_font_scale_get_type : UInt64
		fun pango_font_serialize(font : PangoFont*) : Void*
			fun pango_layout_context_changed(layout : PangoLayout)
		fun pango_layout_copy(src : PangoLayout) : PangoLayout
		fun pango_layout_deserialize(context : PangoContext, bytes : Void*, flags : PangoLayoutDeserializeFlags, error : GError**) : PangoLayout
		fun pango_layout_deserialize_error_get_type : UInt64
		fun pango_layout_deserialize_error_quark : GQuark
		fun pango_layout_deserialize_flags_get_type : UInt64
		fun pango_layout_get_alignment(layout : PangoLayout) : PangoAlignment
		fun pango_layout_get_attributes(layout : PangoLayout) : PangoAttrList
		fun pango_layout_get_auto_dir(layout : PangoLayout) : Bool
		fun pango_layout_get_baseline(layout : PangoLayout) : Int32
		fun pango_layout_get_caret_pos(layout : PangoLayout, index_ : Int32, strong_pos : PangoRectangle*, weak_pos : PangoRectangle*)
		fun pango_layout_get_character_count(layout : PangoLayout) : Int32
		fun pango_layout_get_context(layout : PangoLayout) : PangoContext
		fun pango_layout_get_cursor_pos(layout : PangoLayout, index_ : Int32, strong_pos : PangoRectangle*, weak_pos : PangoRectangle*)
		fun pango_layout_get_direction(layout : PangoLayout, index : Int32) : PangoDirection
		fun pango_layout_get_ellipsize(layout : PangoLayout) : PangoEllipsizeMode
		fun pango_layout_get_extents(layout : PangoLayout, ink_rect : PangoRectangle*, logical_rect : PangoRectangle*)
		fun pango_layout_get_font_description(layout : PangoLayout) : PangoFontDescription
		fun pango_layout_get_height(layout : PangoLayout) : Int32
		fun pango_layout_get_indent(layout : PangoLayout) : Int32
		fun pango_layout_get_iter(layout : PangoLayout) : PangoLayoutIter
		fun pango_layout_get_justify(layout : PangoLayout) : Bool
		fun pango_layout_get_justify_last_line(layout : PangoLayout) : Bool
		fun pango_layout_get_line(layout : PangoLayout, line : Int32) : PangoLayoutLine*
			fun pango_layout_get_line_count(layout : PangoLayout) : Int32
		fun pango_layout_get_line_readonly(layout : PangoLayout, line : Int32) : PangoLayoutLine*
			fun pango_layout_get_line_spacing(layout : PangoLayout) : LibC::Float
		fun pango_layout_get_lines(layout : PangoLayout) : GsList*
			fun pango_layout_get_lines_readonly(layout : PangoLayout) : GsList*
			fun pango_layout_get_log_attrs(layout : PangoLayout, attrs : PangoLogAttr**, n_attrs : Int32*)
		fun pango_layout_get_log_attrs_readonly(layout : PangoLayout, n_attrs : Int32*) : PangoLogAttr*
			fun pango_layout_get_pixel_extents(layout : PangoLayout, ink_rect : PangoRectangle*, logical_rect : PangoRectangle*)
		fun pango_layout_get_pixel_size(layout : PangoLayout, width : Int32*, height : Int32*)
		fun pango_layout_get_serial(layout : PangoLayout) : UInt32
		fun pango_layout_get_single_paragraph_mode(layout : PangoLayout) : Bool
		fun pango_layout_get_size(layout : PangoLayout, width : Int32*, height : Int32*)
		fun pango_layout_get_spacing(layout : PangoLayout) : Int32
		fun pango_layout_get_tabs(layout : PangoLayout) : PangoTabArray
		fun pango_layout_get_text(layout : PangoLayout) : Char*
			fun pango_layout_get_type : UInt64
		fun pango_layout_get_unknown_glyphs_count(layout : PangoLayout) : Int32
		fun pango_layout_get_width(layout : PangoLayout) : Int32
		fun pango_layout_get_wrap(layout : PangoLayout) : PangoWrapMode
		fun pango_layout_index_to_line_x(layout : PangoLayout, index_ : Int32, trailing : Bool, line : Int32*, x_pos : Int32*)
		fun pango_layout_index_to_pos(layout : PangoLayout, index_ : Int32, pos : PangoRectangle*)
		fun pango_layout_is_ellipsized(layout : PangoLayout) : Bool
		fun pango_layout_is_wrapped(layout : PangoLayout) : Bool
		fun pango_layout_iter_at_last_line(iter : PangoLayoutIter) : Bool
		fun pango_layout_iter_copy(iter : PangoLayoutIter) : PangoLayoutIter
		fun pango_layout_iter_free(iter : PangoLayoutIter)
		fun pango_layout_iter_get_baseline(iter : PangoLayoutIter) : Int32
		fun pango_layout_iter_get_char_extents(iter : PangoLayoutIter, logical_rect : PangoRectangle*)
		fun pango_layout_iter_get_cluster_extents(iter : PangoLayoutIter, ink_rect : PangoRectangle*, logical_rect : PangoRectangle*)
		fun pango_layout_iter_get_index(iter : PangoLayoutIter) : Int32
		fun pango_layout_iter_get_layout(iter : PangoLayoutIter) : PangoLayout
		fun pango_layout_iter_get_layout_extents(iter : PangoLayoutIter, ink_rect : PangoRectangle*, logical_rect : PangoRectangle*)
		fun pango_layout_iter_get_line(iter : PangoLayoutIter) : PangoLayoutLine*
			fun pango_layout_iter_get_line_extents(iter : PangoLayoutIter, ink_rect : PangoRectangle*, logical_rect : PangoRectangle*)
		fun pango_layout_iter_get_line_readonly(iter : PangoLayoutIter) : PangoLayoutLine*
			fun pango_layout_iter_get_line_yrange(iter : PangoLayoutIter, y0_ : Int32*, y1_ : Int32*)
		fun pango_layout_iter_get_run(iter : PangoLayoutIter) : PangoLayoutRun*
			fun pango_layout_iter_get_run_baseline(iter : PangoLayoutIter) : Int32
		fun pango_layout_iter_get_run_extents(iter : PangoLayoutIter, ink_rect : PangoRectangle*, logical_rect : PangoRectangle*)
		fun pango_layout_iter_get_run_readonly(iter : PangoLayoutIter) : PangoLayoutRun*
			fun pango_layout_iter_get_type : UInt64
		fun pango_layout_iter_next_char(iter : PangoLayoutIter) : Bool
		fun pango_layout_iter_next_cluster(iter : PangoLayoutIter) : Bool
		fun pango_layout_iter_next_line(iter : PangoLayoutIter) : Bool
		fun pango_layout_iter_next_run(iter : PangoLayoutIter) : Bool
		fun pango_layout_line_get_extents(line : PangoLayoutLine*, ink_rect : PangoRectangle*, logical_rect : PangoRectangle*)
		fun pango_layout_line_get_height(line : PangoLayoutLine*, height : Int32*)
		fun pango_layout_line_get_length(line : PangoLayoutLine*) : Int32
		fun pango_layout_line_get_pixel_extents(layout_line : PangoLayoutLine*, ink_rect : PangoRectangle*, logical_rect : PangoRectangle*)
		fun pango_layout_line_get_resolved_direction(line : PangoLayoutLine*) : PangoDirection
		fun pango_layout_line_get_start_index(line : PangoLayoutLine*) : Int32
		fun pango_layout_line_get_type : UInt64
		fun pango_layout_line_get_x_ranges(line : PangoLayoutLine*, start_index : Int32, end_index : Int32, ranges : Int32**, n_ranges : Int32*)
		fun pango_layout_line_index_to_x(line : PangoLayoutLine*, index_ : Int32, trailing : Bool, x_pos : Int32*)
		fun pango_layout_line_is_paragraph_start(line : PangoLayoutLine*) : Bool
		fun pango_layout_line_ref(line : PangoLayoutLine*) : PangoLayoutLine*
			fun pango_layout_line_unref(line : PangoLayoutLine*)
		fun pango_layout_line_x_to_index(line : PangoLayoutLine*, x_pos : Int32, index_ : Int32*, trailing : Int32*) : Bool
		fun pango_layout_move_cursor_visually(layout : PangoLayout, strong : Bool, old_index : Int32, old_trailing : Int32, direction : Int32, new_index : Int32*, new_trailing : Int32*)
		fun pango_layout_new(context : PangoContext) : PangoLayout
		fun pango_layout_serialize(layout : PangoLayout, flags : PangoLayoutSerializeFlags) : Void*
			fun pango_layout_serialize_flags_get_type : UInt64
		fun pango_layout_set_alignment(layout : PangoLayout, alignment : PangoAlignment)
		fun pango_layout_set_attributes(layout : PangoLayout, attrs : PangoAttrList)
		fun pango_layout_set_auto_dir(layout : PangoLayout, auto_dir : Bool)
		fun pango_layout_set_ellipsize(layout : PangoLayout, ellipsize : PangoEllipsizeMode)
		fun pango_layout_set_font_description(layout : PangoLayout, desc : PangoFontDescription)
		fun pango_layout_set_height(layout : PangoLayout, height : Int32)
		fun pango_layout_set_indent(layout : PangoLayout, indent : Int32)
		fun pango_layout_set_justify(layout : PangoLayout, justify : Bool)
		fun pango_layout_set_justify_last_line(layout : PangoLayout, justify : Bool)
		fun pango_layout_set_line_spacing(layout : PangoLayout, factor : LibC::Float)
		fun pango_layout_set_markup(layout : PangoLayout, markup : Char*, length : Int32)
		fun pango_layout_set_markup_with_accel(layout : PangoLayout, markup : Char*, length : Int32, accel_marker : UInt32, accel_char : UInt32*)
		fun pango_layout_set_single_paragraph_mode(layout : PangoLayout, setting : Bool)
		fun pango_layout_set_spacing(layout : PangoLayout, spacing : Int32)
		fun pango_layout_set_tabs(layout : PangoLayout, tabs : PangoTabArray)
		fun pango_layout_set_text(layout : PangoLayout, text : Char*, length : Int32)
		fun pango_layout_set_width(layout : PangoLayout, width : Int32)
		fun pango_layout_set_wrap(layout : PangoLayout, wrap : PangoWrapMode)
		fun pango_layout_write_to_file(layout : PangoLayout, flags : PangoLayoutSerializeFlags, filename : Char*, error : GError**) : Bool
		fun pango_layout_xy_to_index(layout : PangoLayout, x : Int32, y : Int32, index_ : Int32*, trailing : Int32*) : Bool
		fun pango_parse_markup(markup_text : Char*, length : Int32, accel_marker : UInt32, attr_list : PangoAttrList*, text : Char**, accel_char : UInt32*, error : GError**) : Bool
		fun pango_parse_stretch(str : Char*, stretch : PangoStretch*, warn : Bool) : Bool
		fun pango_parse_style(str : Char*, style : PangoStyle*, warn : Bool) : Bool
		fun pango_parse_variant(str : Char*, variant : PangoVariant*, warn : Bool) : Bool
		fun pango_parse_weight(str : Char*, weight : PangoWeight*, warn : Bool) : Bool
	end
