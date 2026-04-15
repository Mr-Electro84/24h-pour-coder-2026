;; title:  Space Collider
;; author: Brigade anti-virus
;; desc:   Space Collider - Un jeu d'espace
;; script: fennel

;; -- DEBUT DEFINITIONS OBJETS --

;; ## Objet Vaisseau Utilisateur
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

(fn Vaisseau.dessiner [self]
  (spr self.num self.pos_x self.pos_y -1 1 0 0 2 2)
)

;; ## Objet Planete
(local Planete {})
(set Planete.__index Planete)

;; Constructeur
(fn Planete.new [pos_x pos_y rayon gravite couleur]
  (let [instance {:pos_x pos_x :pos_y pos_y :rayon rayon :gravite gravite :couleur couleur}]
    (setmetatable instance Planete)))

;; Méthodes
(fn Planete.desc [self]
  (print (.. "pos x : " self.pos_x " pos y : " self.pos_y) 45 45 12))

(fn Planete.dessiner [self]
  (circ self.pos_x self.pos_y self.rayon self.couleur))

;; -- FIN DEFINITIONS OBJETS --

(var couleur-texte 12)  ; 6 = vert. Essaie 11 (bleu clair)
(var couleur-fond 0)  ; 12 = Blanc. Essaie 0 (Noir)

;; Variable pour l'animation
(var anim_t 0)

;; Variables d'initialisation
(var niveau 0)
(var select_opt_menu 0)
(var musique false)

(local vaisseau (Vaisseau.new 258 5 60 100)) ;; Placer le vaisseau à gauche et au centre

;; Boucle principale exécutée à 60 FPS
(fn _G.TIC []
  ;; 1. Nettoie l'écran
  (cls couleur-fond)

  ;; Lance la musique
  (when (not musique)
    (music 0)
    (set musique true)
  )
  
  ;; 2. Calcule un petit mouvement de vague
  (var decalage-y (* (math.sin anim_t) 5))

  ;; Afficher le niveau si la variable niveau est supérieur à 1
  (when (> niveau 0)
    (print (.. "Niveau : " niveau) 10 10 couleur-texte)
  )

  (if (= niveau 0) ;; Menu principal
      (do
      (print "SPACE COLLIDER" 30 (+ 35 decalage-y) couleur-texte false 2)

      ;; carré de sélection
      (if (= select_opt_menu 0) (rect 18 60 6 6 couleur-texte))
      (if (= select_opt_menu 1) (rect 18 70 6 6 couleur-texte))
      (if (= select_opt_menu 2) (rect 18 80 6 6 couleur-texte))

      ;; menu
      (print "JOUER" 30 60 couleur-texte false 1)
      (print "Skins" 30 70 couleur-texte false 1)
      (print "Configuration" 30 80 couleur-texte false 1)

      (print "Entree pour valider" 30 100 couleur-texte false 1)

      (when (and (btnp 0) (> select_opt_menu 0)) ;; bouton haut
        (set select_opt_menu (- select_opt_menu 1)))
      (when (and (btnp 1) (< select_opt_menu 2)) ;; bouton bas
        (set select_opt_menu (+ select_opt_menu 1)))

      (when (keyp 50)
        (if (= select_opt_menu 0) (set niveau 1))
      )
      
    )
    (when (= niveau 1)
      ;; désactiver la musique
      (when musique
        (music)
        (set musique false)
      )

      (local planete1 (Planete.new 100 100 10 10 10))
      (planete1:dessiner)
      (local planete2 (Planete.new 50 50 10 10 4)) ;; autre couleur et autre placement
      (planete2:dessiner)
      (local planete3 (Planete.new 200 80 10 10 12)) ;; autre couleur et autre placement
      (planete3:dessiner)
      (vaisseau:dessiner)
    )
  )
  
  ;; Fait avancer le temps
  (set anim_t (+ anim_t 0.05)))