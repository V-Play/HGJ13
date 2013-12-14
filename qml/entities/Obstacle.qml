import QtQuick 1.1
import VPlay 1.0
import "../game"

GravityEntity {
  id: obstacle
  entityType: "obstacle"
  poolingEnabled: true
  width: sprite.width
  height: sprite.height

  variationType: "satellite"

  property variant target: undefined
  property real speed: 0.1
  property int distance: 100
  property real angle: 100
  property variant origin: Qt.point(0, 0)
  property alias collisionGroup: collider.groupIndex

  BoxCollider {
    id: collider
    width: sprite.width
    height: sprite.height
    anchors.centerIn: parent
    bodyType: Body.Kinematic
    groupIndex: settingsManager.neutralGroup
    colliderType: settingsManager.obstacleColliderGroup

    fixture.onBeginContact: {
      var fixture = other;
      var body = fixture.parent;
      var component = body.parent;
      var collidedEntity = component.owningEntity;
      var collidedEntityType = collidedEntity.entityType;
      if(collidedEntityType === "rocket") {
        destroyObstacle()
      }
    }
  }

  Particle {
    id: flyer

    //x: sprite.x+sprite.width/2
    //y: sprite.y+sprite.height/2

    // particle file
    fileName: "../particles/BoingStar.json"

    // start when finished loading
    autoStart: false
    //scale: 0.2
    duration: 0.3

    onRunningChanged: {
      if(!running) {
        rmvEntity()
      }
    }
  }

  function destroyObstacle() {
    collider.active = false
    sprite.visible = false
    flyer.start()
  }

  function rmvEntity() {
    scene.removeEntityFromLogic(obstacle)
    obstacle.removeEntity()
  }

  SingleSpriteFromFile {
    id: sprite
    filename: "../img/images-sd.json"
    source: variationType+".png"
    //translateToCenterAnchor: false
  }

  DebugVisual {
    x: -sprite.width/2
    y: -sprite.height/2
    width: sprite.width
    height: sprite.height
  }

  Timer {
    interval: 40
    running: true
    repeat: true
    onTriggered: {
      obstacle.angle += obstacle.speed
      obstacle.x = obstacle.origin.x + Math.cos(obstacle.angle) * obstacle.distance
      obstacle.y = obstacle.origin.y + Math.sin(obstacle.angle) * obstacle.distance
    }
  }
}
