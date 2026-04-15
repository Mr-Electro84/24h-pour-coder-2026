;; title:  Space Collider
;; author: Brigade anti-virus
;; desc:   Space Collider - Un jeu d'espace
;; script: fennel

(var couleur-texte 12)  ; 6 = vert. Essaie 11 (bleu clair)
(var couleur-fond 8)  ; 12 = Blanc. Essaie 0 (Noir)

;; Variable pour l'animation
(var t 0)

;; Variable pour le niveau
(var niveau 0)
(var select_niv 0)
;; -- Objet Vaisseau Utilisateur --
;; Définition du prototype (la "classe")
(local Vaisseau {})
(set Vaisseau.__index Vaisseau)

;; Constructeur
(fn Vaisseau.new [num pos_x pos_y pv]
  (let [instance {:num num :pos_x pos_x :pos_y pos_y :pv pv}]
    (setmetatable instance Vaisseau)))

;; Méthodes
(fn Vaisseau.desc [self]
  (print (.. "pos x : " self.pos_x " pos y : " self.pos_y " pv : " self.pv) 45 45 12))

(fn Vaisseau.deplacer [self delta_x delta_y]
  (set self.pos_x (+ self.pos_x delta_x))
  (set self.pos_y (+ self.pos_y delta_y))
)

;; Boucle principale exécutée à 60 FPS
(fn _G.TIC []
  ;; 1. Nettoie l'écran
  (cls couleur-fond)
  
  ;; 2. Calcule un petit mouvement de vague
  (var decalage-y (* (math.sin t) 5))
  
  ;; 3. Affiche le texte au centre avec l'effet de vague
  ;;(print "WORKFLOW OPERATIONNEL !" 45 (+ 64 decalage-y) couleur-texte) ;; (print "texte" x y couleur)

  (local vais (Vaisseau.new 0 100 100 100))
  ;;(vais:desc)

  (if (= niveau 0) ;; Menu principal
      (do
      (print "SPACE COLLIDER" 30 (+ 45 decalage-y) couleur-texte false 2)
      ;; Menu principal (bouton commencer)
      (print "PLAY" 30 70 couleur-texte false 1)
      (print "Skin" 30 80 couleur-texte false 1)
      (print "Settings" 30 90  couleur-texte false 1))

      (when (and (btn 0) (> select_niv 0)) (set select_niv (+ select_niv 1)))
      (when (and (btn 1) (< select_niv 2)) (set select_niv (- select_niv 1)))

      (print (.. select_niv) 100 10 0)
  )
  
  ;; 4. Fait avancer le temps
  (set t (+ t 0.1)))