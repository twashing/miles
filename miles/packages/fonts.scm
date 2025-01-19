
;; To build/test this package locally, you can run:
;;   guix build -f fonts.scm
;;
;; Or install it locally (with --fallback if you're not connected to the
;; internet, as Guix might otherwise try to substitute from build farms):
;;   guix package -f fonts.scm

(define-module (miles packages fonts)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system font)
  #:use-module (guix licenses)
  #:use-module (guix gexp)
  #:use-module (gnu packages fontutils))  ; For reference if needed

(define-public font-pragmata-pro-liga
  (package
   (name "font-pragmata-pro-liga")
   (version "1.0")

   (source
    (origin
     (method url-fetch)
     (uri "https://www.dropbox.com/scl/fi/fpti0f347bfye49f6wc7f/PragmataPro-ep6wq.zip?rlkey=gx7rgfbs5frvrnn5e9k1gggid&st=hje0azz0&dl=1")
     (sha256
      (base32
       "0cna4wavnhnb8j8vg119ap8mqkckx04z2gms2hsz4daywc51ghr8"
       (file-name
        ;; "PragmataPro-ep6wq.zip?rlkey=gx7rgfbs5frvrnn5e9k1gggid"
        "PragmataPro-ep6wq.zip?rlkey=gx7rgfbs5frvrnn5e9k1gggid&st=hje0azz0&dl=1"
        )))))

   (build-system font-build-system)
   (arguments
    `(#:phases
      (modify-phases %standard-phases
                     (delete 'build)             ; Not needed for just installing fonts
                     (replace 'install
                              (lambda* (#:key outputs #:allow-other-keys)
                                       (let* ((out (assoc-ref outputs "out"))
                                              (fonts-dir (string-append out "/share/fonts/truetype")))
                                         (mkdir-p fonts-dir)

                                         ;; Copy all .ttf files found in the extracted zip. Adjust file names:
                                         (install-file "PragmataProR_liga_0830.ttf" fonts-dir)
                                         (install-file "PragmataProB_liga_0830.ttf" fonts-dir)
                                         (install-file "PragmataProI_liga_0830.ttf" fonts-dir)
                                         (install-file "PragmataProZ_liga_0830.ttf" fonts-dir)
                                         (install-file "PragmataPro_Mono_R_liga_0830.ttf" fonts-dir)
                                         (install-file "PragmataPro_Mono_B_liga_0830.ttf" fonts-dir)
                                         (install-file "PragmataPro_Mono_I_liga_0830.ttf" fonts-dir)
                                         (install-file "PragmataPro_Mono_Z_liga_0830.ttf" fonts-dir)

                                         #t))))))
   (home-page "")
   (synopsis "A multi-style font for Pragmata Pro Liga")
   (description "Pragmata Pro Liga font package, with styles for Regular, Bold, Italic and Bold Italic, for the Noraml space and Mono space.")

   (license #f)))

font-pragmata-pro-liga
