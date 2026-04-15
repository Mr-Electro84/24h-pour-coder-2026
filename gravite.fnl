;; title:  Space Collider
;; author: Brigade anti-virus
;; desc:   Space Collider - Un jeu d'espace
;; script: fennel
(var couleur-texte 12)  ; 6 = vert. Essaie 11 (bleu clair)
(var couleur-fond 8)  ; 12 = Blanc. Essaie 0 (Noir)
(var angle 0)

;; Variable pour l'animation
(var t 0)

;; Variable pour le niveau
(var niveau 0)

;; -- Objet Vaisseau Utilisateur --
;; Définition du prototype (la "classe")
(local Vaisseau {})
(set Vaisseau.__index Vaisseau)

(fn Vaisseau.new [num pos_x pos_y pv]
  (let [instance {:num num :pos_x pos_x :pos_y pos_y :pv pv :vx 0 :vy 0}]
    (setmetatable instance Vaisseau)))

(fn Vaisseau.desc [self]
  (print (.. "pos x : " self.pos_x " pos y : " self.pos_y " pv : " self.pv) 45 45 12))

(fn Vaisseau.deplacer [self delta_x delta_y]
  (set self.pos_x (+ self.pos_x delta_x))
  (set self.pos_y (+ self.pos_y delta_y))
)
(local Planete {})
(set Planete.__index Planete)
(fn Planete.new [num pos_x pos_y pv]
  (let [instance {:num num :pos_x pos_x :pos_y pos_y :pv pv}]
    (setmetatable instance Planete)))

(fn Planete.desc [self]
  (print (.. "pos x : " self.pos_x " pos y : " self.pos_y) 45 45 ))

(fn Planete.deplacer [self delta_x delta_y]
  (set self.pos_x (+ self.pos_x delta_x))
  (set self.pos_y (+ self.pos_y delta_y))
)

(local vaisseau (Vaisseau.new 0 100 100 100))
(local planete (Planete.new 0 100 40 100))

(fn _G.TIC []
  (cls couleur-fond)

  ;; -------------------------
  ;; FORWARD MOVEMENT (always right)
  ;; -------------------------
  (set vaisseau.vx 1.5)

  ;; -------------------------
  ;; NEAR GRAVITY (curve only)
  ;; -------------------------
  (let [
    dx (- planete.pos_x vaisseau.pos_x)
    dy (- planete.pos_y vaisseau.pos_y)
    dist (math.sqrt (+ (* dx dx) (* dy dy)))

    nx (- dy)
    ny dx

    force (if (< dist 80)
            (/ 0.25 (math.max dist 10))
            0)
  ]
    (set vaisseau.vy (+ vaisseau.vy (* ny force))))

  ;; -------------------------
  ;; APPLY MOVEMENT
  ;; -------------------------
  (vaisseau:deplacer vaisseau.vx vaisseau.vy)

  ;; -------------------------
  ;; DAMPING (vertical only)
  ;; -------------------------
  (set vaisseau.vy (* vaisseau.vy 0.97))

  ;; -------------------------
  ;; DRAW
  ;; -------------------------
  (spr 288 planete.pos_x planete.pos_y 0 1 0 0 4 4)
  (spr 256 vaisseau.pos_x vaisseau.pos_y 0 1 0 0 2 2)
)