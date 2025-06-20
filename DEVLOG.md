# Devlog – Arcane Depths

Hier dokumentiere ich die Entwicklung meines Spiels **Arcane Depths**. Jede Version oder Woche bekommt einen eigenen Eintrag. Änderungen, Ideen und Probleme werden hier festgehalten.

---

## [2025-06-15] – GitHub Setup
- Projekt erstmals mit GitHub verbunden 
- Strukturierung und Kommentierung bereits vorhandender Skripte

## [2025-06-18]
- Bodendesign in der Lobby
    - Überarbeitetes Tileset mit neuer Erdtextur
    - Shader zum Verdunkeln nach unten
- Kamera
    - Vertikale, veränderbare, Positionslimitierung
    - Eigene Node + Skript um Effekte besser handlen zu können
    - Shaking-Effekt
- Lobbydesign
    - 2 Buschtypen
    
## [2025-06-19]
- Lobbydesign
    - 3 neue Büsche
    - kleiner Baum

## [2025-06-20]
- Lobbydesign
    - Einfache Wolken, die mithilfe von Shader sich bewegen und loopen
- Löschen von Lobby
- Erstellen von Tutorial-Szene
    - Spieler respawnt wenn er in Abgrund fällt und führt eine Animation aus

## [2025-06-21] - Komponent-System
- HealthComponent
- HurtboxComponent
- HitboxComponent
- AnimatedSpriteComponent
- DamageComponent
- ProjectileStatusEffectComponent
