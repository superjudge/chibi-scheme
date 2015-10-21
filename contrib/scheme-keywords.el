;; scheme-keywords.el
;; Scheme R7RS-small syntax highlighting and keyword completion for GNU Emacs
;; Copyright (c) 2015 Frère Jérôme. Contributed to the `Chibi-Scheme' project
;; under the same BSD-style license: http://synthcode.com/license.txt

;; The *optional* keyword completion is provided by the `company' framework
;; See: https://company-mode.github.io

;; Installation:

;; If necessary, add the location of this file to your Emacs `load-path':
;; (add-to-list 'load-path "FILE LOCATION")

;; Add the following lines to your `.emacs' configuration file:
;; (when (require 'scheme-keywords nil t)
;;   (add-to-list 'auto-mode-alist '("\\.sld\\'" . scheme-mode))
;;   ;; CUSTOMIZATION HERE
;; )

;; Customization:

;; (add-scheme-keywords 'LIST 'FACE) ;; define additional highlights
;; (setq scheme-keywords-completions 'LIST) ;; define additional completions

(require 'company nil t)
(require 'cl)

(defconst scheme-procedures-list
  '("and"
    "begin"
    "call\/cc"
    "call-with-current-continuation"
    "call-with-input-file"
    "call-with-output-file"
    "call-with-port"
    "call-with-values"
    "case"
    "case-lambda"
    "cond"
    "cond-expand"
    "cons"
    "define"
    "define-library"
    "define-record-type"
    "define-syntax"
    "define-values"
    "delay"
    "delay-force"
    "do"
    "dynamic-wind"
    "else"
    "eof-object"
    "export"
    "features"
    "force"
    "for-each"
    "if"
    "import"
    "include"
    "include-ci"
    "lambda"
    "let"
    "let\*"
    "letrec"
    "letrec\*"
    "letrec-syntax"
    "let-syntax"
    "let-values"
    "let\*-values"
    "library"
    "list"
    "load"
    "not"
    "or"
    "quasiquote"
    "quote"
    "scheme-report-environment"
    "syntax-error"
    "syntax-rules"
    "unless"
    "unquote"
    "unquote-splicing"
    "values"
    "when"))

(defconst scheme-operators-list
  '("\<"
    "\<\="
    "\="
    "\=\>"
    "\>"
    "\>\="
    "\_"
    "\-"
    "\/"
    "\.\.\."
    "\*"
    "\+"
    "caaaar"
    "caaadr"
    "caaar"
    "caadar"
    "caaddr"
    "caadr"
    "caar"
    "cadaar"
    "cadadr"
    "cadar"
    "caddar"
    "cadddr"
    "caddr"
    "cadr"
    "car"
    "cdaaar"
    "cdaadr"
    "cdaar"
    "cdadar"
    "cdaddr"
    "cdadr"
    "cdar"
    "cddaar"
    "cddadr"
    "cddar"
    "cdddar"
    "cddddr"
    "cdddr"
    "cddr"
    "cdr"
    "\#f"
    "\#false"
    "\#t"
    "\#true"))

(defconst scheme-predicates-list
  '("binary-port\?"
    "boolean\=\?"
    "boolean\?"
    "bytevector"
    "bytevector\?"
    "char\<\=\?"
    "char\<\?"
    "char\=\?"
    "char\>\=\?"
    "char\>\?"
    "char\?"
    "char-alphabetic\?"
    "char-ci\<\=\?"
    "char-ci\<\?"
    "char-ci\=\?"
    "char-ci\>\=\?"
    "char-ci\>\?"
    "char-numeric\?"
    "char-ready\?"
    "char-lower-case\?"
    "char-upper-case\?"
    "char-whitespace\?"
    "complex\?"
    "eof-object\?"
    "eq\?"
    "equal\?"
    "eqv\?"
    "error-object\?"
    "even\?"
    "exact\?"
    "exact-integer\?"
    "file-error\?"
    "file-exists\?"
    "finite\?"
    "inexact\?"
    "infinite\?"
    "input-port\?"
    "input-port-open\?"
    "integer\?"
    "list\?"
    "nan\?"
    "negative\?"
    "null\?"
    "number\?"
    "odd\?"
    "output-port\?"
    "output-port-open\?"
    "pair\?"
    "port\?"
    "positive\?"
    "procedure\?"
    "promise\?"
    "rational\?"
    "read-error\?"
    "real\?"
    "string\<\=\?"
    "string\<\?"
    "string\=\?"
    "string\>\=\?"
    "string\>\?"
    "string\?"
    "string-ci\<\=\?"
    "string-ci\<\?"
    "string-ci\=\?"
    "string-ci\>\=\?"
    "string-ci\>\?"
    "symbol\=\?"
    "symbol\?"
    "textual-port\?"
    "u8-ready\?"
    "vector\?"
    "zero\?"))

(defconst scheme-mutations-list
  '("bytevector-copy\!"
    "bytevector-u8-set\!"
    "list-set\!"
    "read-bytevector\!"
    "set\!"
    "set-car\!"
    "set-cdr\!"
    "string-copy\!"
    "string-fill\!"
    "string-set\!"
    "vector-copy\!"
    "vector-fill\!"
    "vector-set\!"))

(defconst scheme-exceptions-list
  '("emergency-exit"
    "error"
    "error-object-message"
    "error-object-irritants"
    "exit"
    "guard"
    "raise"
    "raise-continuable"
    "with-exception-handler"))

(defconst scheme-functions-list
  '("abs"
    "acos"
    "angle"
    "append"
    "apply"
    "asin"
    "assoc"
    "assq"
    "assv"
    "atan"
    "bytevector"
    "bytevector-append"
    "bytevector-copy"
    "bytevector-length"
    "bytevector-u8-ref"
    "ceiling"
    "ceiling\/"
    "ceiling-quotient"
    "ceiling-remainder"
    "centered\/"
    "centered-quotient"
    "centered-remainder"
    "char-downcase"
    "char-foldcase"
    "char-\>integer"
    "char-upcase"
    "close-input-port"
    "close-output-port"
    "close-port"
    "command-line"
    "cos"
    "current-error-port"
    "current-input-port"
    "current-jiffy"
    "current-output-port"
    "current-second"
    "delete-file"
    "denominator"
    "digit-value"
    "display"
    "environment"
    "euclidean\/"
    "euclidean-quotient"
    "euclidean-remainder"
    "exact"
    "exact-\>inexact"
    "exact-integer-sqrt"
    "exp"
    "expt"
    "floor"
    "floor\/"
    "floor-quotient"
    "floor-remainder"
    "flush-output-port"
    "gcd"
    "get-environment-variable"
    "get-environment-variables"
    "get-output-bytevector"
    "get-output-string"
    "imag-part"
    "inexact"
    "inexact-\>exact"
    "integer-\>char"
    "interaction-environment"
    "jiffies-per-second"
    "lcm"
    "length"
    "list-copy"
    "list-ref"
    "list-\>string"
    "list-tail"
    "list-\>vector"
    "log"
    "magnitude"
    "make-bytevector"
    "make-list"
    "make-parameter"
    "make-polar"
    "make-promise"
    "make-rectangular"
    "make-string"
    "make-vector"
    "map"
    "max"
    "member"
    "memq"
    "memv"
    "min"
    "modulo"
    "newline"
    "null-environment"
    "number-\>string"
    "numerator"
    "open-binary-input-file"
    "open-binary-output-file"
    "open-input-bytevector"
    "open-input-file"
    "open-input-string"
    "open-output-bytevector"
    "open-output-file"
    "open-output-string"
    "parameterize"
    "peek-char"
    "peek-u8"
    "quotient"
    "rationalize"
    "read"
    "read-bytevector"
    "read-char"
    "read-line"
    "read-string"
    "read-u8"
    "real-part"
    "remainder"
    "reverse"
    "round"
    "round\/"
    "round-quotient"
    "round-remainder"
    "sin"
    "sqrt"
    "square"
    "string"
    "string-append"
    "string-copy"
    "string-downcase"
    "string-foldcase"
    "string-for-each"
    "string-length"
    "string-\>list"
    "string-map"
    "string-\>number"
    "string-ref"
    "string-\>symbol"
    "string-upcase"
    "string-\>utf8"
    "string-\>vector"
    "substring"
    "symbol-\>string"
    "tan"
    "truncate"
    "truncate\/"
    "truncate-quotient"
    "truncate-remainder"
    "utf8-\>string"
    "vector"
    "vector-append"
    "vector-copy"
    "vector-for-each"
    "vector-length"
    "vector-\>list"
    "vector-map"
    "vector-ref"
    "vector-\>string"
    "with-input-from-file"
    "with-output-to-file"
    "write"
    "write-bytevector"
    "write-char"
    "write-shared"
    "write-simple"
    "write-string"
    "write-u8"))

(defvar scheme-keywords-completions '())

(defun scheme-add-keywords (keywords face)
  "Add keywords to Scheme mode."
  (interactive (list 'interactive))
  (let ((keyword-list (concat "\\<\\(" (regexp-opt keywords) "\\)\\>")))
    (font-lock-add-keywords 'scheme-mode
                            `((,keyword-list 1 ',face)))))

(scheme-add-keywords scheme-procedures-list
                     'font-lock-keyword-face)
(scheme-add-keywords scheme-operators-list
                     'font-lock-builtin-face)
(scheme-add-keywords scheme-predicates-list
                     'font-lock-type-face)
(scheme-add-keywords scheme-mutations-list
                     'font-lock-type-face)
(scheme-add-keywords scheme-exceptions-list
                     'font-lock-warning-face)
(scheme-add-keywords scheme-functions-list
                     'font-lock-function-name-face)

(defun scheme-keywords-hook ()
  (when (featurep 'company)
    (defun company-scheme-keywords
        (command &optional argument &rest ignored)
      (interactive (list 'interactive))
      (case command
        (interactive (company-begin-backend 'company-scheme-keywords))
        (prefix (and (eq major-mode 'scheme-mode) (company-grab-symbol)))
        (candidates (remove-if-not
                     (lambda (candidate)
                       (string-prefix-p argument candidate))
                     (append scheme-procedures-list scheme-operators-list
                             scheme-predicates-list scheme-mutations-list
                             scheme-exceptions-list scheme-functions-list
                             scheme-keywords-completions)))))
    (add-to-list 'company-backends 'company-scheme-keywords)))
(add-hook 'scheme-mode-hook 'scheme-keywords-hook)

(provide 'scheme-keywords)
