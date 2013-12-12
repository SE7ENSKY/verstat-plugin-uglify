module.exports = (next) ->
	UglifyJS = require 'uglify-js'
	@postprocessor 'uglify',
		extname: '.js'
		priority: 50
		postprocess: (file, donePostprocessor) =>
			return donePostprocessor() unless file.uglify
			try
				if file.processor
					file.processed = UglifyJS.minify(file.processed, fromString: yes).code
				else
					file.source = UglifyJS.minify(file.source, fromString: yes).code
				@modified file
				donePostprocessor()
			catch err
				donePostprocessor err

	next()