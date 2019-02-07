/**
 * jQuery validation plug-in 1.5.1 Cutomizing
 * @author ks-park
 * @since 2009-01-30
 */
 
/*
 * jQuery validation plug-in 1.5.1
 *
 * http://bassistance.de/jquery-plugins/jquery-plugin-validation/
 * http://docs.jquery.com/Plugins/Validation
 *
 * Copyright (c) 2006 - 2008 Jorn Zaefferer
 *
 * $Id: jquery.validate.js 6096 2009-01-12 14:12:04Z joern.zaefferer $
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 */

(function($) {

$.extend($.fn, {
	// http://docs.jquery.com/Plugins/Validation/validate
	validate: function( options ) {
		// if nothing is selected, return nothing; can't chain anyway
		if (!this.length) {
			options && options.debug && window.console && console.warn( "nothing selected, can't validate, returning nothing" );
			return;
		}
		
		// check if a validator for this form was already created
		var validator = $.data(this[0], 'validator');
		if ( validator ) {
			return validator;
		}
		
		validator = new $.validator( options, this[0] );
		$.data(this[0], 'validator', validator); 
		
		/**
		 * validate 선언 시 각 입력 element를 위치 지정용 element 속으로 집어 넣기. 
		 * @since 2009-03-19
		 * @author ks-park
		 * @update 2009-03-23 상위 element가 position: relative;가 적용되지 않는 경우에만 상위에 div element를 생성.
		 */
		for ( var i = 0, elements = (this.currentElements = validator.elements()); elements[i]; i++ ) {
			if($(elements[i]).parent('td').size() > 0 || $(elements[i]).parent('dd').size() > 0) {
//				if(elements[i].nodeName == 'TEXTAREA') {
					$(elements[i]).parent().wrapInner('<div class="error-position-relative"></div>');
//				} else {
//					$(elements[i]).parent().wrapInner('<span class="error-position-relative"></span>');
//				}
			}
		}
		
		if ( validator.settings.onsubmit ) {

			// allow suppresing validation by adding a cancel class to the submit button
			this.find("input, button").filter(".cancel").click(function() {
				validator.cancelSubmit = true;
			});
			this.find("input, image").filter(".cancel").click(function(){
				validator.cancelSubmit = true;
			});
			//이현제 추가(2012.01.13) input img 중 id가 cancel인 이미지의 cancel submit 처리 
			this.find("img").filter(".cancel").click(function(){
				validator.cancelSubmit = true;
			});
			// validate the form on submit
			this.submit( function( event ) {
				if ( validator.settings.debug )
					// prevent form submit to be able to see console output
					event.preventDefault();
					
				function handle() {
					if ( validator.settings.submitHandler ) {
						validator.settings.submitHandler.call( validator, validator.currentForm );
						return false;
					}
					return true;
				}
					
				// prevent submit for invalid forms or custom submit handlers
				if ( validator.cancelSubmit ) {
					validator.cancelSubmit = false;
					return handle();
				}
				if ( validator.form() ) {
					// 폼검증 성공 시 beforeSubmit을 호출하여 submit을 진행할 지 안할 지 결정 할 수 있다.
					if( validator.settings.beforeSubmit ) {
						if( validator.settings.beforeSubmit(validator.currentForm) === false) {
							return false;
						}	
					}
					if ( validator.pendingRequest ) {
						validator.formSubmitted = true;
						return false;
					}
					return handle();
				} else if($.isFunction(validator.settings.errorFunction)) { 
					return false;
				} else {
					validator.focusInvalid();
					return false;
				}
			});
		}
		
		return validator;
	},
	// http://docs.jquery.com/Plugins/Validation/valid
	valid: function() {
        if ( $(this[0]).is('form')) {
            return this.validate().form();
        } else {
            var valid = false;
            var validator = $(this[0].form).validate();
            this.each(function() {
				valid |= validator.element(this);
            });
            return valid;
        }
    },
	// attributes: space seperated list of attributes to retrieve and remove
	removeAttrs: function(attributes) {
		var result = {},
			$element = this;
		$.each(attributes.split(/\s/), function(index, value) {
			result[value] = $element.attr(value);
			$element.removeAttr(value);
		});
		return result;
	},

	
	// http://docs.jquery.com/Plugins/Validation/rules
	rules: function(command, argument) {
		var element = this[0];
		
		if (command) {
			var settings = $.data(element.form, 'validator').settings;
			var staticRules = settings.rules;
			var existingRules = $.validator.staticRules(element);
			switch(command) {
			case "add":
				$.extend(existingRules, $.validator.normalizeRule(argument));
				staticRules[element.name] = existingRules;
				if (argument.messages)
					settings.messages[element.name] = $.extend( settings.messages[element.name], argument.messages );
				break;
			case "remove":
				if (!argument) {
					delete staticRules[element.name];
					return existingRules;
				}
				var filtered = {};
				$.each(argument.split(/\s/), function(index, method) {
					filtered[method] = existingRules[method];
					delete existingRules[method];
				});
				return filtered;
			}
		}
		
		var data = $.validator.normalizeRules(
		$.extend(
			{},
			$.validator.metadataRules(element),
			$.validator.classRules(element),
			$.validator.attributeRules(element),
			$.validator.staticRules(element)
		), element);
		
		// make sure required is at front
		if (data.required) {
			var param = data.required;
			delete data.required;
			data = $.extend({required: param}, data);
		}
		
		return data;
	}
});

// Custom selectors
$.extend($.expr[":"], {
	// http://docs.jquery.com/Plugins/Validation/blank
	blank: function(a) {return !$.trim(a.value);},
	// http://docs.jquery.com/Plugins/Validation/filled
	filled: function(a) {return !!$.trim(a.value);},
	// http://docs.jquery.com/Plugins/Validation/unchecked
	unchecked: function(a) {return !a.checked;}
});


$.format = function(source, params) {
	if ( arguments.length == 1 ) 
		return function() {
			var args = $.makeArray(arguments);
			args.unshift(source);
			return $.format.apply( this, args );
		};
	if ( arguments.length > 2 && params.constructor != Array  ) {
		params = $.makeArray(arguments).slice(1);
	}
	if ( params.constructor != Array ) {
		params = [ params ];
	}
	$.each(params, function(i, n) {
		source = source.replace(new RegExp("\\{" + i + "\\}", "g"), n);
	});
	return source;
};

// constructor for validator
$.validator = function( options, form ) {
	this.settings = $.extend( {}, $.validator.defaults, options );
	this.currentForm = form;
	this.init();
};

$.extend($.validator, {

	defaults: {
		messages: {},
		groups: {},
		rules: {},
		errorClass: "error",
		errorElement: "div",
		focusInvalid: true,
		errorContainer: $( [] ),
		errorLabelContainer: $( [] ),
		onsubmit: true,
		ignore: [],
		ignoreTitle: false,
		onchange: function() {
			this.element(element);
		},
		onfocusin: function(element) {
			/**
			 * 타 element에서의 변경사항으로 조건이 충족되었을때가 바로 확인 되도록 수정.
			 * @author ks-park
			 * @since 2009-01-28
			 */
			$(element).css('border','1px solid #007db5');
			/*if( !this.checkable(element) && $(element).val()) {
			}*/
			// 오류로 인해 주석처리.
//			this.lastActive = element;
				
			// hide error label and remove error class on focus if enabled
//			if ( this.settings.focusCleanup && !this.blockFocusCleanup ) {
//				this.settings.unhighlight && this.settings.unhighlight.call( this, element, this.settings.errorClass );
//				this.errorsFor(element).hide();
//			}
		},
		onfocusout: function(element) {
			// ks-park : 실시간 확인을 위해 추가
			$(element).css('border','1px solid #007db5');
			this.element(element);
			
//			if ( !this.checkable(element) && (element.name in this.submitted || !this.optional(element)) ) {
//				this.element(element);
//			}
		},
		onkeyup: function(element) {
			// ks-park : 실시간 확인을 위해 추가
			/*this.element(element);*/
			
//			if ( element.name in this.submitted || element == this.lastElement ) {
//				this.element(element);
//			}
		},
		onclick: function(element) {
			// ks-park : 실시간 확인을 위해 추가
			/*if( this.checkable(element) || $(element).val() ) {
				this.element(element);
			} else if ( element.name in this.submitted )
				this.element(element);*/
		},
		highlight: function( element, errorClass ) {
			$( element ).addClass( errorClass );
			$(element).css('border','1px dotted #007db5');
		},
		unhighlight: function( element, errorClass ) {
			$( element ).removeClass( errorClass );
		},
		
		/**
		 * form submit() 시 첫 오류만 보여 주도록 설정할 수 있다.(true 일 경우.)
		 * @author ks-park
		 * @since 2009-01-28
		 */
		firstShow: false,
		
		/**
		 * 타 오류창은 닫히고 현재의 오류창만 나오도록 수정.
		 * @author ks-park
		 * @since 2009-01-29
		 */
		currentShow: true,
		
		errorFunction: function(message) {			
			alert(message);
		},
		
		/**
		 * 위치 및 오류 창의 길이를 설정할 수 있다.
		 * @author ks-park
		 * @since 2009-01-28
		 * @update 2009-01-29
		 */
		defaultPosition: {
			down: {
				top: -45,
				left: 10
			},
			up: {
				top: 0,
				left: 10
			},
			left: {
				top: -15,
				left: 0
			},
			arrow: 'down'
		},
		positions: {
			'default': {
				top: false,
				left: false,
				arrow: 'down'
			}
		}
	},

	// http://docs.jquery.com/Plugins/Validation/Validator/setDefaults
	setDefaults: function(settings) {
		$.extend( $.validator.defaults, settings );
	},

	/**
	 * 기본 에러메세지를 한글화.
	 * @author ks-park
	 * @since 2009-01-30
	 */
	messages: {
		required: "입력해 주세요.",
		remote: "올바른 값으로 수정해 주세요.",
		email: "메일 주소 양식에 맞지 않습니다.",
		url: "URL 형식이 맞지 않습니다.",
		domain: "올바른 도메인 형식이 아닙니다.",
		date: "날짜 형식이 맞지 않습니다.",
//		dateISO: "날짜 형식이 맞지 않습니다. (ISO).",
		dateDE: "Bitte geben Sie ein gultiges Datum ein.",
		number: "숫자 형식으로 입력해 주세요.",
		numberDE: "Bitte geben Sie eine Nummer ein.",
		digits: "숫자만을 입력해 주세요.",
		creditcard: "Please enter a valid credit card number.",
		equalTo: "값이 동일하지 않습니다.",
		accept: "허용된 확장자가 아닙니다.",
		maxlength: $.format("{0} 자를  초과하였습니다."),
		minlength: $.format("{0} 자 미만입니다."),
		rangelength: $.format("{0} 자 이상 {1} 이하로 작성해 주세요."),
		range: $.format("값이 {0} ~ {1} 사이 이어야 합니다."),
		max: $.format("값이 {0} 를 초과하였습니다."),
		min: $.format("값이 {0} 미만입니다."),
		jumin: '올바른 주민등록번호가 아닙니다.',
		bizNumber: '올바른 사업자등록번호가 아닙니다.',
		userid: '첫글자는 영문으로 시작하여야하며 영문/숫자만 사용되어야 합니다.',
		tablename: '첫글자가 영소문자로 시작해야하며 영소문자/숫자/_ 만을 사용할 수 있습니다.',
		minlengthUTF8: $.format("{0} 자 미만입니다."),
		maxlengthUTF8: $.format("{0} 자를  초과하였습니다."),
		rangelengthUTF8: $.format("{0} 자 이상 {1} 이하로 작성해 주세요."),
		phone: '올바른 전화번호 형식이 아닙니다.',
		cellular: '올바른 휴대폰번호 형식이 아닙니다.',
		percent: $.format("올바른 백분율 형식이 아닙니다. 소숫점은 {0} 자까지 허용됩니다."),
		password2: "올바른 비밀번호 형식이 아닙니다. 영대․소문자, 숫자, 특수문자 중 2종류 이상으로 구성되어야 합니다."
	},

	autoCreateRanges: false,
	
	prototype: {
		
		init: function() {
			this.labelContainer = $(this.settings.errorLabelContainer);
			this.errorContext = this.labelContainer.length && this.labelContainer || $(this.currentForm);
			this.containers = $(this.settings.errorContainer).add( this.settings.errorLabelContainer );
			this.submitted = {};
			this.valueCache = {};
			this.pendingRequest = 0;
			this.pending = {};
			this.invalid = {};
			this.reset();
			
			var groups = (this.groups = {});
			$.each(this.settings.groups, function(key, value) {
				$.each(value.split(/\s/), function(index, name) {
					groups[name] = key;
				});
			});
			var rules = this.settings.rules;
			$.each(rules, function(key, value) {
				rules[key] = $.validator.normalizeRule(value);
			});
			
			function delegate(event) {
				var validator = $.data(this[0].form, "validator");
				if(validator) {
					validator.settings["on" + event.type] && validator.settings["on" + event.type].call(validator, this[0] );
				}
			}
			$(this.currentForm)
				.delegate("focusin focusout keyup", ":text, :password, :file, select, textarea", delegate)
				.delegate("click", ":radio, :checkbox", delegate);

			if (this.settings.invalidHandler)
				$(this.currentForm).bind("invalid-form.validate", this.settings.invalidHandler);
		},

		// http://docs.jquery.com/Plugins/Validation/Validator/form
		form: function() {
			this.checkForm();
			$.extend(this.submitted, this.errorMap);
			this.invalid = $.extend({}, this.errorMap);
			if (!this.valid())
				$(this.currentForm).triggerHandler("invalid-form", [this]);
			//this.showErrors(); //modal.alert의 z-index가 밀려서 그냥 안뿌려버림 ㅋ
			return this.valid();
		},
		
		checkForm: function() {
			this.prepareForm();
			for ( var i = 0, elements = (this.currentElements = this.elements()); elements[i]; i++ ) {
				this.check( elements[i] );
				
				/*
				 * 제일 첫 오류만 보여 주도록 수정.
				 */
				var _error = this.valid();
				if(!_error && this.settings.firstShow) {
					return _error; 
					break;
				}
				
				if($.isFunction(this.settings.errorFunction) && !_error) {
					this.settings.errorFunction(this.errorList[0].message);
					break;
				}
			}
			return this.valid(); 
		},
		
		// http://docs.jquery.com/Plugins/Validation/Validator/element
		element: function( element ) {
//			if($(element).parent('span.error-position-relative').size() < 1) {
//				$(element).before('<span class="error-position-relative"></span>');
//				$(element).appendTo($(element).prev()).focus();
//			}
			
			if(this.settings.firstShow) {
				var errorElements = $(this.settings.errorElement+'.'+this.settings.errorClass).size();
			}
	
			if(errorElements < 1 || !this.settings.firstShow || this.lastElement.name == element.name) {
				if(this.settings.currentShow) {
					this.removeAllErrors();
				}
			
				element = this.clean( element );
				this.lastElement = element;
				this.prepareElement( element );
				this.currentElements = $(element);
				var result = this.check( element );
				if ( result ) {
					delete this.invalid[element.name];
				} else {
					this.invalid[element.name] = true;
				}
				if ( !this.numberOfInvalids() ) {
					// Hide error containers on last error
					this.toHide = this.toHide.add( this.containers );
				}
				this.showErrors();
				return result;
			}
		},
		
		/**
		 * 모든 오류창을 제거.
		 * @author ks-park
		 * @since 2009-01-29
		 */
		removeAllErrors: function() {
			$(this.settings.errorElement+'.'+this.settings.errorClass).remove();
		},
		
		// http://docs.jquery.com/Plugins/Validation/Validator/showErrors
		showErrors: function(errors) {
			if(errors) {
				// add items to error list and map
				$.extend( this.errorMap, errors );
				this.errorList = [];
				for ( var name in errors ) {
					this.errorList.push({
						message: errors[name],
						element: this.findByName(name)[0]
					});
				}
				// remove items from success list
				this.successList = $.grep( this.successList, function(element) {
					return !(element.name in errors);
				});
			}
			this.settings.showErrors
				? this.settings.showErrors.call( this, this.errorMap, this.errorList )
				: this.defaultShowErrors();
		},
		
		// http://docs.jquery.com/Plugins/Validation/Validator/resetForm
		resetForm: function() {
			if ( $.fn.resetForm )
				$( this.currentForm ).resetForm();
			this.submitted = {};
			this.prepareForm();
			this.hideErrors();
			this.elements().removeClass( this.settings.errorClass );
		},
		
		numberOfInvalids: function() {
			return this.objectLength(this.invalid);
		},
		
		objectLength: function( obj ) {
			var count = 0;
			for ( var i in obj )
				count++;
			return count;
		},
		
		hideErrors: function() {
			this.addWrapper( this.toHide ).hide();
		},
		
		valid: function() {
			return this.size() == 0;
		},
		
		size: function() {
			return this.errorList.length;
		},
		
		focusInvalid: function() {
			if( this.settings.focusInvalid ) {
				try {
					$(this.findLastActive() || this.errorList.length && this.errorList[0].element || []).filter(":visible").focus();
				} catch(e) {
					// ignore IE throwing errors when focusing hidden elements
				}
			}
		},
		
		findLastActive: function() {
			var lastActive = this.lastActive;
			return lastActive && $.grep(this.errorList, function(n) {
				return n.element.name == lastActive.name;
			}).length == 1 && lastActive;
		},
		
		elements: function() {
			var validator = this,
				rulesCache = {};
			
			// select all valid inputs inside the form (no submit or reset buttons)
			// workaround $Query([]).add until http://dev.jquery.com/ticket/2114 is solved
			return $([]).add(this.currentForm.elements)
			.filter(":input")
			.not(":submit, :reset, :image, [disabled]")
			.not( this.settings.ignore )
			.filter(function() {
				!this.name && validator.settings.debug && window.console && console.error( "%o has no name assigned", this);
				/**
				 * 동일한 name일 경우 다음 element 부터는 검증하지 않는 문제로 인해 주석 처리.
				 */
				// select only the first element for each name, and only those with rules specified
//				if ( this.name in rulesCache || !validator.objectLength($(this).rules()) )
//					return false;
				
//				rulesCache[this.name] = true;
				return true;
			});
		},
		
		clean: function( selector ) {
			return $( selector )[0];
		},
		
		errors: function() {
			return $( this.settings.errorElement + "." + this.settings.errorClass, this.errorContext );
		},
		
		reset: function() {
			this.successList = [];
			this.errorList = [];
			this.errorMap = {};
			this.toShow = $([]);
			this.toHide = $([]);
			this.formSubmitted = false;
			this.currentElements = $([]);
		},
		
		prepareForm: function() {
			this.reset();
			this.toHide = this.errors().add( this.containers );
		},
		
		prepareElement: function( element ) {
			this.reset();
			this.toHide = this.errorsFor(element);
		},
	
		check: function( element ) {
			element = this.clean( element );
			
			// if radio/checkbox, validate first element in group instead
			if (this.checkable(element)) {
				element = this.findByName( element.name )[0];
			}
			
			var rules = $(element).rules();
			var dependencyMismatch = false;
			for( method in rules ) {
				var rule = { method: method, parameters: rules[method] };
				try {
					var result = $.validator.methods[method].call( this, element.value, element, rule.parameters );
					
					// if a method indicates that the field is optional and therefore valid,
					// don't mark it as valid when there are no other rules
					if ( result == "dependency-mismatch" ) {
						dependencyMismatch = true;
						continue;
					}
					dependencyMismatch = false;
					
					if ( result == "pending" ) {
						this.toHide = this.toHide.not( this.errorsFor(element) );
						return;
					}
					
					if( !result ) {
						this.formatAndAdd( element, rule );
						return false;
					}
				} catch(e) {
					this.settings.debug && window.console && console.log("exception occured when checking element " + element.id
						 + ", check the '" + rule.method + "' method");
					throw e;
				}
			}
			if (dependencyMismatch)
				return;
			if ( this.objectLength(rules) )
				this.successList.push(element);
			return true;
		},
		
		// return the custom message for the given element and validation method
		// specified in the element's "messages" metadata
		customMetaMessage: function(element, method) {
			if (!$.metadata)
				return;
			
			var meta = this.settings.meta
				? $(element).metadata()[this.settings.meta]
				: $(element).metadata();
			
			return meta && meta.messages && meta.messages[method];
		},
		
		// return the custom message for the given element name and validation method
		customMessage: function( name, method ) {
			var m = this.settings.messages[name];
			return m && (m.constructor == String
				? m
				: m[method]);
		},
		
		// return the first defined argument, allowing empty strings
		findDefined: function() {
			for(var i = 0; i < arguments.length; i++) {
				if (arguments[i] !== undefined)
					return arguments[i];
			}
			return undefined;
		},
		
		defaultMessage: function( element, method) {
			return this.findDefined(
				this.customMessage( element.name, method ),
				this.customMetaMessage( element, method ),
				// title is never undefined, so handle empty string as undefined
				!this.settings.ignoreTitle && element.title || undefined,
				$.validator.messages[method],
				"<strong>Warning: No message defined for " + element.name + "</strong>"
			);
		},
		
		formatAndAdd: function( element, rule ) {
			var message = this.defaultMessage( element, rule.method );
			if ( typeof message == "function" ) 
				message = message.call(this, rule.parameters, element);
			this.errorList.push({
				message: message,
				element: element
			});
			this.errorMap[element.name] = message;
			this.submitted[element.name] = message;
		},
		
		addWrapper: function(toToggle) {
			if ( this.settings.wrapper )
				toToggle = toToggle.add( toToggle.parents( this.settings.wrapper ) );
			return toToggle;
		},
		
		defaultShowErrors: function() {
			for ( var i = 0; this.errorList[i]; i++ ) {
				var error = this.errorList[i];
				this.settings.highlight && this.settings.highlight.call( this, error.element, this.settings.errorClass );
				this.showLabel( error.element, error.message );
			}
			if( this.errorList.length ) {
				this.toShow = this.toShow.add( this.containers );
			}
			if (this.settings.success) {
				for ( var i = 0; this.successList[i]; i++ ) {
					this.showLabel( this.successList[i] );
				}
			}
			if (this.settings.unhighlight) {
				for ( var i = 0, elements = this.validElements(); elements[i]; i++ ) {
					this.settings.unhighlight.call( this, elements[i], this.settings.errorClass );
				}
			}
			this.toHide = this.toHide.not( this.toShow );
			this.hideErrors();
			this.addWrapper( this.toShow ).show();
		},
		
		validElements: function() {
			return this.currentElements.not(this.invalidElements());
		},
		
		invalidElements: function() {
			return $(this.errorList).map(function() {
				return this.element;
			});
		},
		
		showLabel: function(element, message) {
			var label = this.errorsFor( element );
			if ( label.length ) {
				// refresh error/success class
				label.removeClass().addClass( this.settings.errorClass );
			
				// check if we have a generated label, replace the message then
				label.attr("generated") && label.html(message);
			} else {
				// create label
				label = $("<" + this.settings.errorElement + "/>")
//					.attr({"for":  this.idOrName(element), generated: true})
					.addClass(this.settings.errorClass)
					.css('top', 0)
					.css('left', 0);
//					.html(message || "");
					
				/**
				 * tooltip으로 오류 창이 뜨도록 수정
				 * @author ks-park
				 * @since 2009-01-19
				 * @update 2009-01-28
				 */	
//				label.css('position', 'absolute'); //0305
				$(element).parent().css('position', 'relative');
//				var _position = $(element).position(); //0305
				var _positions = this.settings.positions[element.name];
				if(_positions) {
					var _top = _positions.top;
					var _left = _positions.left;
					var _arrow = _positions.arrow;
				} else {
					var _top = false;
					var _left = false;
					var _arrow = false;
				}
				
				if(!_arrow) {
					_arrow = this.settings.defaultPosition.arrow;
				}
				
				if(_top) {
//					label.css('top', _position.top + _top); //0305
					label.css('top', _top);	
				} else {
					switch(_arrow) {
						case 'down':
							var newTop = 0 - label.height();
							label.css('top', newTop);
//							label.css('top', this.settings.defaultPosition.down.top + newTop);
							break;
						case 'up':
							label.css('top', this.settings.defaultPosition.up.top + $(element).height());
							break;
						case 'left':
							label.css('top', 0);
							break;
					}
				}
				
				if(_left) {
//					label.css('left', _position.left + _left); //0305
					label.css('left', _left);	
				} else {
					switch(_arrow) {
						case 'down':
							label.css('left', this.settings.defaultPosition.down.left);
							break;
						case 'up':
							label.css('left', this.settings.defaultPosition.up.left);
							break;
						case 'left':
							label.css('left', $(element).width());
							break;
					}
				}
				
				/*
				if(_width) {
					label.css('width', _width);	
				} else if(!$(element).css('width')) {
					label.css('width', this.settings.defaultPosition.width);	
				}
				*/
				

				if ( this.settings.wrapper ) {
					// make sure the element is visible, even in IE
					// actually showing the wrapped element is handled elsewhere
					label = label.hide().show().wrap("<" + this.settings.wrapper + "/>").parent();
				}
				if ( !this.labelContainer.append(label).length )
					this.settings.errorPlacement
						? this.settings.errorPlacement(label, $(element) )
						: label.insertAfter(element);
			}
			if ( !message && this.settings.success ) {
				label.text("");
				typeof this.settings.success == "string"
					? label.addClass( this.settings.success )
					: this.settings.success( label );
			}
			this.toShow = this.toShow.add(label);
			
			label.append('<div class="error-message-box"></div>');
			label.children('div.error-message-box').append('<span class="error-message"></span>');
			label.children('div.error-message-box').children('span.error-message').html(message || "");
			
			switch(_arrow) {
				case 'down':
					label.append('<div class="error-arrow-down"><img src="/js/JQuery/css/images/jquery.validate.customizing/arrow_down_s.gif" width="10" height="7" alt="" /></div>');
					break;
				case 'up':
					label.prepend('<div class="error-arrow-up"><img src="/js/JQuery/css/images/jquery.validate.customizing/arrow_up_s.gif" width="10" height="7" alt="" /></div>');
					break;
				case 'left':
					label.prepend('<div class="error-arrow-left"><img src="/js/JQuery/css/images/jquery.validate.customizing/arrow_left_s.gif" width="7" height="10" alt="" /></div>');
					break;
			}
							
			/**
			 * 오류내용에 따라 오류창의 가로 길이를 자동으로 늘림.
			 * @author ks-park
			 * @since 2009-01-30
			 */
			var minHeight = parseInt(label.find('span.error-message').css('font-size'), 10) * 2;
			while(label.find('span.error-message').height() >= minHeight) {
				var _width = label.width();	
				var newWidth = _width + 10;
				label.css('width', newWidth+'px');
				if(newWidth > $(window).width()) {
					break;
				}
			}
			
			/**
			 * tooltip으로 오류 창이 뜨도록 수정
			 * @author ks-park
			 * @since 2009-01-19
			 * @update 2009-01-28
			 */	
//			label.css('position', 'absolute'); //0305
			$(element).parent().css('position', 'relative');
//			var _position = $(element).position(); //0305
			var _positions = this.settings.positions[element.name];
			if(_positions) {
				var _top = _positions.top;
				var _left = _positions.left;
				var _arrow = _positions.arrow;
			} else {
				var _top = false;
				var _left = false;
				var _arrow = false;
			}
			
			if(!_arrow) {
				_arrow = this.settings.defaultPosition.arrow;
			}
			
			if(_top) {
//				label.css('top', _position.top + _top); //0305
				label.css('top', _top);	
			} else {
				switch(_arrow) {
					case 'down':
						var newTop = 0 - label.height();
						label.css('top', newTop);
//							label.css('top', this.settings.defaultPosition.down.top + newTop);
						break;
					case 'up':
						label.css('top', $(element).height() + label.children('.error-arrow-up').height());
						break;
					case 'left':
						label.css('top', this.settings.defaultPosition.left.top);
						break;
				}
			}
			
			if(_left) {
//				label.css('left', _position.left + _left); //0305
				label.css('left', _left);	
			} else {
				switch(_arrow) {
					case 'down':
						label.css('left', this.settings.defaultPosition.down.left);
						break;
					case 'up':
						label.css('left', this.settings.defaultPosition.up.left);
						break;
					case 'left':
						label.css('left', $(element).width()+label.children('.error-arrow-up > img').width()+'px');
						break;
				}
			}
		},
		
		errorsFor: function(element) {
			return this.errors().filter("[for='" + this.idOrName(element) + "']");
		},
		
		idOrName: function(element) {
			return this.groups[element.name] || (this.checkable(element) ? element.name : element.id || element.name);
		},

		checkable: function( element ) {
			return /radio|checkbox/i.test(element.type);
		},
		
		findByName: function( name ) {
			// select by name and filter by form for performance over form.find("[name=...]")
			var form = this.currentForm;
			return $(document.getElementsByName(name)).map(function(index, element) {
				return element.form == form && element.name == name && element  || null;
			});
		},
		
		getLength: function(value, element) {
			switch( element.nodeName.toLowerCase() ) {
			case 'select':
				return $("option:selected", element).length;
			case 'input':
				if( this.checkable( element) )
					return this.findByName(element.name).filter(':checked').length;
			}
			return value.length;
		},
		
		/**
		 * utf8 환경에서 문자열 길이를 구함.
		 * 한글의 경우 2byte로 처리.
		 * @author ks-park
		 * @since 2009-01-28
		 */
		getLengthUTF8: function(value, element) {
			switch( element.nodeName.toLowerCase() ) {
			case 'select':
				return $("option:selected", element).length;
			case 'input':
				if( this.checkable( element) )
					return this.findByName(element.name).filter(':checked').length;
			}
			
			var size = 0;
			for (var i=0; i<value.length; i++) {
				var c = escape(value.charAt(i));
				if (c.length == 1) size++;
				else if (c.indexOf("%u") != -1) size += 2;
				else if (c.indexOf("%") != -1) size += c.length/3;
			}		
			
			return size;
		},
		
		/**
		 * 타 element와 연계하여 온전한 data를 반환.
		 * @author ks-park
		 * @since 2009-01-28
		 */
		getChaining: function(param, type, value) {
			if(param.length) {
				var ids = param.split(type);	
				var idsCount = ids.length;
				var absoluteValue = '';
				for(var i = 0; i < idsCount; i++) {
					if(ids[i]) {
						if(absoluteValue) {
							absoluteValue += type+$(ids[i]).val();
						} else {
							absoluteValue = $(ids[i]).val();
						}
					} else {
						if(absoluteValue) {
							absoluteValue += type+value;	
						} else {
							absoluteValue = value;
						}
					}
				}
				
				if(absoluteValue) {
					value = absoluteValue;
				}
			}
			
			return value;
		},
		
		depend: function(param, element) {
			return this.dependTypes[typeof param]
				? this.dependTypes[typeof param](param, element)
				: true;
		},
	
		dependTypes: {
			"boolean": function(param, element) {
				return param;
			},
			"string": function(param, element) {
				return !!$(param, element.form).length;
			},
			"function": function(param, element) {
				return param(element);
			}
		},
		
		optional: function(element) {
			return !$.validator.methods.required.call(this, $.trim(element.value), element) && "dependency-mismatch";
		},
		
		startRequest: function(element) {
			if (!this.pending[element.name]) {
				this.pendingRequest++;
				this.pending[element.name] = true;
			}
		},
		
		stopRequest: function(element, valid) {
			this.pendingRequest--;
			// sometimes synchronization fails, make sure pendingRequest is never < 0
			if (this.pendingRequest < 0)
				this.pendingRequest = 0;
			delete this.pending[element.name];
			if ( valid && this.pendingRequest == 0 && this.formSubmitted && this.form() ) {
				$(this.currentForm).submit();
			} else if (!valid && this.pendingRequest == 0 && this.formSubmitted) {
				$(this.currentForm).triggerHandler("invalid-form", [this]);
			}
		},
		
		previousValue: function(element) {
			return $.data(element, "previousValue") || $.data(element, "previousValue", previous = {
				old: null,
				valid: true,
				message: this.defaultMessage( element, "remote" )
			});
		}
		
	},
	
	classRuleSettings: {
		required: {required: true},
		email: {email: true},
		url: {url: true},
		date: {date: true},
		dateISO: {dateISO: true},
		dateDE: {dateDE: true},
		number: {number: true},
		numberDE: {numberDE: true},
		digits: {digits: true},
		creditcard: {creditcard: true}
	},
	
	addClassRules: function(className, rules) {
		className.constructor == String ?
			this.classRuleSettings[className] = rules :
			$.extend(this.classRuleSettings, className);
	},
	
	classRules: function(element) {
		var rules = {};
		var classes = $(element).attr('class');
		classes && $.each(classes.split(' '), function() {
			if (this in $.validator.classRuleSettings) {
				$.extend(rules, $.validator.classRuleSettings[this]);
			}
		});
		return rules;
	},
	
	attributeRules: function(element) {
		var rules = {};
		var $element = $(element);
		
		for (method in $.validator.methods) {
			var value = $element.attr(method);
			if (value) {
				rules[method] = value;
			}
		}
		
		// maxlength may be returned as -1, 2147483647 (IE) and 524288 (safari) for text inputs
		if (rules.maxlength && /-1|2147483647|524288/.test(rules.maxlength)) {
			delete rules.maxlength;
		}
		
		return rules;
	},
	
	metadataRules: function(element) {
		if (!$.metadata) return {};
		
		var meta = $.data(element.form, 'validator').settings.meta;
		return meta ?
			$(element).metadata()[meta] :
			$(element).metadata();
	},
	
	staticRules: function(element) {
		var rules = {};
		var validator = $.data(element.form, 'validator');
		if (validator.settings.rules) {
			rules = $.validator.normalizeRule(validator.settings.rules[element.name]) || {};
		}
		return rules;
	},
	
	normalizeRules: function(rules, element) {
		// handle dependency check
		$.each(rules, function(prop, val) {
			// ignore rule when param is explicitly false, eg. required:false
			if (val === false) {
				delete rules[prop];
				return;
			}
			if (val.param || val.depends) {
				var keepRule = true;
				switch (typeof val.depends) {
					case "string":
						keepRule = !!$(val.depends, element.form).length;
						break;
					case "function":
						keepRule = val.depends.call(element, element);
						break;
				}
				if (keepRule) {
					rules[prop] = val.param !== undefined ? val.param : true;
				} else {
					delete rules[prop];
				}
			}
		});
		
		// evaluate parameters
		$.each(rules, function(rule, parameter) {
			rules[rule] = $.isFunction(parameter) ? parameter(element) : parameter;
		});
		
		// clean number parameters
		$.each(['minlength', 'maxlength', 'min', 'max'], function() {
			if (rules[this]) {
				rules[this] = Number(rules[this]);
			}
		});
		$.each(['rangelength', 'range'], function() {
			if (rules[this]) {
				rules[this] = [Number(rules[this][0]), Number(rules[this][1])];
			}
		});
		
		if ($.validator.autoCreateRanges) {
			// auto-create ranges
			if (rules.min && rules.max) {
				rules.range = [rules.min, rules.max];
				delete rules.min;
				delete rules.max;
			}
			if (rules.minlength && rules.maxlength) {
				rules.rangelength = [rules.minlength, rules.maxlength];
				delete rules.minlength;
				delete rules.maxlength;
			}
		}
		
		// To support custom messages in metadata ignore rule methods titled "messages"
		if (rules.messages) {
			delete rules.messages
		}
		
		return rules;
	},
	
	// Converts a simple string to a {string: true} rule, e.g., "required" to {required:true}
	
	normalizeRule: function(data) {
		if( typeof data == "string" ) {
			var transformed = {};
			$.each(data.split(/\s/), function() {
				transformed[this] = true;
			});
			data = transformed;
		}
		return data;
	},
	
	// http://docs.jquery.om/Plugins/Validation/Validator/addMethod
	
	addMethod: function(name, method, message) {
		$.validator.methods[name] = method;
		$.validator.messages[name] = message;
		if (method.length < 3) {
			$.validator.addClassRules(name, $.validator.normalizeRule(name));
		}
	},

	methods: {

		// http://docs.jquery.com/Plugins/Validation/Methods/required
		required: function(value, element, param) {
			// check if dependency is met
			if ( !this.depend(param, element) )
				return "dependency-mismatch";
			switch( element.nodeName.toLowerCase() ) {
			case 'select':
				var options = $("option:selected", element);
				return options.length > 0 && ( element.type == "select-multiple" || ($.browser.msie && !(options[0].attributes['value'].specified) ? options[0].text : options[0].value).length > 0);
			case 'input':
				if ( this.checkable(element) )
					return this.getLength(value, element) > 0;
			default:
				return $.trim(value).length > 0;
			}
		},
		
		// http://docs.jquery.com/Plugins/Validation/Methods/remote
		remote: function(value, element, param) {
			if ( this.optional(element) )
				return "dependency-mismatch";
			
			var previous = this.previousValue(element);
			
			if (!this.settings.messages[element.name] )
				this.settings.messages[element.name] = {};
			this.settings.messages[element.name].remote = typeof previous.message == "function" ? previous.message(value) : previous.message;
			
			param = typeof param == "string" && {url:param} || param; 
			
			if ( previous.old !== value ) {
				previous.old = value;
				var validator = this;
				this.startRequest(element);
				var data = {};
				data[element.name] = value;

				 //var s = eval("({'data':'false', 'w':'2', 'c':'3'})");

				// var s = eval("({'data':'false'})");
				// alert(s);
				 //alert(s.data);

				//alert(element.name);
				//var json_str = "{'" + element.name + "':'" + value + "'}";
				//var man = eval("(" + json_str + ")");
				//alert(data.MEB_WID);

				//$.getJSON($.extend(true, {
				$.ajax($.extend(true, {
					url: param,
					type: 'POST',
					mode: "abort",
					port: "validate" + element.name,
					dataType: "json",
					//async: false,
					//timeout: 10000,
					data: data,
					error: function() {
						alert('처리가 완료되지 않았습니다. 다시 시도해 주세요.');
					},
					success: function(response) {

						if ( response ) {
							var submitted = validator.formSubmitted;
							validator.prepareElement(element);
							validator.formSubmitted = submitted;
							validator.successList.push(element);
							validator.showErrors();
						} else {
							var errors = {};
							errors[element.name] =  response || validator.defaultMessage( element, "remote" );
							validator.showErrors(errors);
						}

						previous.valid = response;
						validator.stopRequest(element, response);
					}
					
				}, param));
				return "pending";
			} else if( this.pending[element.name] ) {
				return "pending";
			}
			return previous.valid;
		},

		// http://docs.jquery.com/Plugins/Validation/Methods/minlength
		minlength: function(value, element, param) {
			return this.optional(element) || this.getLength($.trim(value), element) >= param;
		},
		
		// http://docs.jquery.com/Plugins/Validation/Methods/maxlength
		maxlength: function(value, element, param) {
			return this.optional(element) || this.getLength($.trim(value), element) <= param;
		},
		
		// http://docs.jquery.com/Plugins/Validation/Methods/rangelength
		rangelength: function(value, element, param) {
			var length = this.getLength($.trim(value), element);
			return this.optional(element) || ( length >= param[0] && length <= param[1] );
		},
		
		// http://docs.jquery.com/Plugins/Validation/Methods/min
		min: function( value, element, param ) {
			return this.optional(element) || value >= param;
		},
		
		// http://docs.jquery.com/Plugins/Validation/Methods/max
		max: function( value, element, param ) {
			return this.optional(element) || value <= param;
		},
		
		// http://docs.jquery.com/Plugins/Validation/Methods/range
		range: function( value, element, param ) {
			return this.optional(element) || ( value >= param[0] && value <= param[1] );
		},
		
		/**
		 * email 입력란이 나눠져 있을 경우에 대한 처리를 위해 수정
		 * @author ks-park
		 * @since 2009-01-21
		 */
		// http://docs.jquery.com/Plugins/Validation/Methods/email
		email: function(value, element, param) {
			value = this.getChaining(param, '@', value);	
			// contributed by Scott Gonzalez: http://projects.scottsplayground.com/email_address_validation/
			return this.optional(element) || /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i.test(value);
		},
	
		// http://docs.jquery.com/Plugins/Validation/Methods/url
		url: function(value, element) {
			// contributed by Scott Gonzalez: http://projects.scottsplayground.com/iri/
			return this.optional(element) || /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(value);
		},
        
		/**
		 * 도메인만 입력받도록 검증
		 * @author juriel
		 * @since 2009-04-27
		 */
		domain: function(value, element) {
			return this.optional(element) || /([_0-9a-z-]+(\.[_0-9a-z-]+)+)$/i.test(value);
		},
		
		/**
		 * 도메인만 입력받도록 검증(한글 도메인도 허용)
		 * @author juriel
		 * @since 2009-04-27
		 */
		domainKorean: function(value, element) {
			return this.optional(element) || /([\uAC00-\uD7A3_0-9a-z-]+(\.[\uAC00-\uD7A3_0-9a-z-]+)+)$/i.test(value);
		},
		
		/**
		 * 날짜 검증.
		 * @author ks-park
		 * @since 2009-01-28
		 */
		date: function(value, element, param) {
			value = this.getChaining(param, '-', value);	
			return this.optional(element) || /^\d{4}[\/-]\d{1,2}[\/-]\d{1,2}$/.test(value);
		},
		
		// http://docs.jquery.com/Plugins/Validation/Methods/date
//		date: function(value, element) {
//			return this.optional(element) || !/Invalid|NaN/.test(new Date(value));
//		},
	
		// http://docs.jquery.com/Plugins/Validation/Methods/dateISO
//		dateISO: function(value, element, param) {
//			return this.optional(element) || /^\d{4}[\/-]\d{1,2}[\/-]\d{1,2}$/.test(value);
//		},
	
		// http://docs.jquery.com/Plugins/Validation/Methods/dateDE
		dateDE: function(value, element) {
			return this.optional(element) || /^\d\d?\.\d\d?\.\d\d\d?\d?$/.test(value);
		},
	
		// http://docs.jquery.com/Plugins/Validation/Methods/number
		number: function(value, element) {
			return this.optional(element) || /^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/.test(value);
		},
	
		// http://docs.jquery.com/Plugins/Validation/Methods/numberDE
		numberDE: function(value, element) {
			return this.optional(element) || /^-?(?:\d+|\d{1,3}(?:\.\d{3})+)(?:,\d+)?$/.test(value);
		},
		
		// http://docs.jquery.com/Plugins/Validation/Methods/digits
		digits: function(value, element) {

			//digits일경우 0이면 return false;
			if(value==0)return false; 
			return this.optional(element) || /^\d+$/.test(value);
		},
		
		// http://docs.jquery.com/Plugins/Validation/Methods/creditcard
		// based on http://en.wikipedia.org/wiki/Luhn
		creditcard: function(value, element) {
			if ( this.optional(element) )
				return "dependency-mismatch";
			// accept only digits and dashes
			if (/[^0-9-]+/.test(value))
				return false;
			var nCheck = 0,
				nDigit = 0,
				bEven = false;

			value = value.replace(/\D/g, "");

			for (n = value.length - 1; n >= 0; n--) {
				var cDigit = value.charAt(n);
				var nDigit = parseInt(cDigit, 10);
				if (bEven) {
					if ((nDigit *= 2) > 9)
						nDigit -= 9;
				}
				nCheck += nDigit;
				bEven = !bEven;
			}

			return (nCheck % 10) == 0;
		},
		
		// http://docs.jquery.com/Plugins/Validation/Methods/accept
		accept: function(value, element, param) {
			param = typeof param == "string" ? param : "png|jpeg|gif";
			return this.optional(element) || value.match(new RegExp(".(" + param + ")$", "i")); 
		},
		
		// http://docs.jquery.com/Plugins/Validation/Methods/equalTo
		equalTo: function(value, element, param) {
			return value == $(param).val();
		},
		
		/**
		 * 주민등록번호 확인을 위한 기능 추가.
		 * @author ks-park
		 * @since 2009-01-20
		 */
		jumin: function(value, element, param) {
			if(!this.optional(element)) {
				var juminNumber = this.getChaining(param, '-', value);	
				
				var pattern = /^([0-9]{6})-?([0-9]{7})$/; 
				if (!pattern.test(juminNumber)) {
					return false;
				}
	
				num = RegExp.$1 + RegExp.$2;
	
				var sum = 0;
				var last = num.charCodeAt(12) - 0x30;
				var bases = "234567892345";
				for (var i=0; i<12; i++) {
					if (isNaN(num.substring(i,i+1))) {
						return false;
					}
					sum += (num.charCodeAt(i) - 0x30) * (bases.charCodeAt(i) - 0x30);
				}
				var mod = sum % 11;
	
				return ((11 - mod) % 10 == last) ? true : false;
			} else {
				return true;
			}
		},
		
		/**
		 * 사업자등록번호 확인을 위한 기능 추가
		 * @author yb-seok
		 * @since 2009-05-07
		 * @update 2009-05-07
		 */
		bizNumber: function(value, element, param) {
			if(!this.optional(element)) {
				var bizNumber = this.getChaining(param, '-', value);	
					
				var pattern = /([0-9]{3})-?([0-9]{2})-?([0-9]{5})/; 
				if (!pattern.test(bizNumber)) {
					return false; 
				}
				
				var num = RegExp.$1 + RegExp.$2 + RegExp.$3;
				var cVal = 0; 
				for (var i=0; i<8; i++) 
				{ 
					var cKeyNum = parseInt(((_tmp = i % 3) == 0) ? 1 : ( _tmp  == 1 ) ? 3 : 7); 
					cVal += (parseFloat(num.substring(i,i+1)) * cKeyNum) % 10; 
				} 
				var li_temp = parseFloat(num.substring(i,i+1)) * 5 + '0'; 
				cVal += parseFloat(li_temp.substring(0,1)) + parseFloat(li_temp.substring(1,2)); 
				return (parseInt(num.substring(9,10)) == (10-(cVal%10))%10) ? true : false;
			} else {
				return true;
			}	
		},
		
		/**
		 * 첫글자가 영문으로 시작, 영문/숫자만 사용되었는지 확인.
		 * @author ks-park
		 * @since 2009-01-20
		 */
		userid: function(value, element) {
			return this.optional(element) || /^[a-zA-Z]{1}[a-zA-Z0-9]+$/.test(value);
		},
		
		/**
		 * 첫글자가 영소문자로 시작, 영소문자/숫자/언더바만 사용되었는지 확인.
		 * @author ks-park
		 * @since 2009-01-30
		 */
		tablename: function(value, element) {
			return this.optional(element) || /^[a-z]{1}[a-z0-9_]+$/.test(value);
		},	
		
		
		/**
		 * 최소 10자리 이상 : 영대․소문자, 숫자, 특수문자 중 2종류 이상으로 구성되었는지 확인.
		 * @author mr-kim
		 * @since 2013-01-10
		 */
		/** 숫자 체크 */
		test1: function(value, element) {
			return this.optional(element) || /[0-9_]+$/.test(value);
		},	

		/** 영소,대문자 체크 */
		test2: function(value, element) {
			return this.optional(element) || /[a-zA-Z_]+$/.test(value);
		},	
		/** 특수문자 체크 */
		test3: function(value, element) {
			$special = '!"#$%&\'()*+,-./:;<=>?@[\]^_`{|}~'; 
			$special = preg_quote($special);
			return this.optional(element) || /([_  -]+(\.[_  -]+)+)$/i.test(value);
		},	
		
		
		
		
		password2: function(value, element, param) {
			if(!this.optional(element)) {
					var password2 = this.getChaining(param, '-', value);	

				var num = 0;				
				var regexp = /[^(가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9)]/gi;  // 숫자,영문,특수문자
		       for( var i=0; i<password2.length; i++){
		            if(password2.charAt(i) != " " && regexp.test(password2.charAt(i)) == true ){
		            num++;
		             break;
		            }
		        }   
		        
		        var num1 = 0;				
				var regexp1 = /[0-9]/; // 숫자만
		        
		        for( var i=0; i<password2.length; i++){
		            if(password2.charAt(i) != " " && regexp1.test(password2.charAt(i)) == true ){
		            num1++;
		             break;
		            }
		        }   
		        
		        var num2 = 0;				
				var regexp2 = /[a-zA-Z]/; // 영문만
				
		        for( var i=0; i<password2.length; i++){
		            if(password2.charAt(i) != " " && regexp2.test(password2.charAt(i)) == true ){
		            num2++;
		             break;
		            }
		        }   
		        
		        
		        var total = parseInt(num)+parseInt(num1)+parseInt(num2);
		        
				if (parseInt(total) >= 2) {
					return true; 
				}
				
			} else {
				return false;
			}	
		},
		
		
		
		
		/**
		 * utf8 환경에서 한글을 2byte로 처리하여 최소 길이를 정함.
		 * @author ks-park
		 * @since 2009-01-28
		 */
		minlengthUTF8: function(value, element, param) {
			return this.optional(element) || this.getLengthUTF8($.trim(value), element) >= param;
		},
		
		/**
		 * utf8 환경에서 한글을 2byte로 처리하여 최대 길이를 정함.
		 * @author ks-park
		 * @since 2009-01-28
		 */
		maxlengthUTF8: function(value, element, param) {
			return this.optional(element) || this.getLengthUTF8($.trim(value), element) <= param;
		},
		
		/**
		 * utf8 환경에서 한글을 2byte로 처리하여 길이 범위를 정함.
		 * @author ks-park
		 * @since 2009-01-28
		 */
		rangelengthUTF8: function(value, element, param) {
			var length = this.getLengthUTF8($.trim(value), element);
			return this.optional(element) || ( length >= param[0] && length <= param[1] );
		},
		
		/**
		 * 전화번호 검증.
		 * @author ks-park
		 * @since 2009-01-28
		 * @update 전국대표전화도 허용하도록 수정. 2009-03-25
		 */
		phone: function(value, element, param) {
			value = this.getChaining(param, '-', value);	
			if(this.optional(element) || /^([0]{1}[0-9]{1,3})-?([1-9]{1}[0-9]{2,3})-?([0-9]{4})$/.test(value)) {
				return true;
			} else if(/^([1]{1}[5|6]{1}(44|88|99))-?([0-9]{4})$/.test(value)) {
				return true;
			} else {
				return false;
			}
		},
		
		/**
		 * 핸드폰 번호 검증.
		 * @author ks-park
		 * @since 2009-01-28
		 */
		cellular: function(value, element, param) {
			value = this.getChaining(param, '-', value);	
			return this.optional(element) || /^([0]{1}[1]{1}[016789]{1})-?([1-9]{1}[0-9]{2,3})-?([0-9]{4})$/.test(value);
		},
		
		/**
		 * 백분율 검증
		 * @author ks-park
		 * @since 2009-01-29
		 */
		percent: function(value, element, param) {
			if(param === false) {
				return true;
			}
			
			var ex = Math.pow(10, param);
			var percent = Math.floor(value * ex) / ex;
			if( this.optional(element) || (value == percent && value <= 100) ) {
				return true;
			} else {
				return false;
			}
		}	
	}
});

})(jQuery);

// ajax mode: abort
// usage: $.ajax({ mode: "abort"[, port: "uniqueport"]});
// if mode:"abort" is used, the previous request on that port (port can be undefined) is aborted via XMLHttpRequest.abort() 
;(function($) {
	var ajax = $.ajax;
	var pendingRequests = {};
	$.ajax = function(settings) {
		// create settings for compatibility with ajaxSetup
		settings = $.extend(settings, $.extend({}, $.ajaxSettings, settings));
		var port = settings.port;
		if (settings.mode == "abort") {
			if ( pendingRequests[port] ) {
				pendingRequests[port].abort();
			}
			return (pendingRequests[port] = ajax.apply(this, arguments));
		}
		return ajax.apply(this, arguments);
	};
})(jQuery);

// provides cross-browser focusin and focusout events
// IE has native support, in other browsers, use event caputuring (neither bubbles)

// provides delegate(type: String, delegate: Selector, handler: Callback) plugin for easier event delegation
// handler is only called when $(event.target).is(delegate), in the scope of the jquery-object for event.target 

// provides triggerEvent(type: String, target: Element) to trigger delegated events
;(function($) {
	$.each({
		focus: 'focusin',
		blur: 'focusout'	
	}, function( original, fix ){
		$.event.special[fix] = {
			setup:function() {
				if ( $.browser.msie ) return false;
				this.addEventListener( original, $.event.special[fix].handler, true );
			},
			teardown:function() {
				if ( $.browser.msie ) return false;
				this.removeEventListener( original,
				$.event.special[fix].handler, true );
			},
			handler: function(e) {
				arguments[0] = $.event.fix(e);
				arguments[0].type = fix;
				return $.event.handle.apply(this, arguments);
			}
		};
	});
	$.extend($.fn, {
		delegate: function(type, delegate, handler) {
			return this.bind(type, function(event) {
				var target = $(event.target);
				if (target.is(delegate)) {
					return handler.apply(target, arguments);
				}
			});
		},
		triggerEvent: function(type, target) {
			return this.triggerHandler(type, [$.event.fix({ type: type, target: target })]);
		}
	})
})(jQuery);
