import VPlay 1.0
import QtQuick 1.1
import "../menu"

SceneBase {
  id: scene

  Background {
    anchors.centerIn: scene.gameWindowAnchorItem
    source: "../img/bg_ingame-sd.png"
  }

  onBackPressed:  {
    audioManager.stopMusic()
    audioManager.playMusic(audioManager.idMusicBG)
    audioManager.play(audioManager.idBUTTON)
    sceneLoader.activateResultScene()
  }

  onEnterPressed: {
    audioManager.stopMusic()
    audioManager.playMusic(audioManager.idMusicBG)
    audioManager.play(audioManager.idBUTTON)
    sceneLoader.activateResultScene()
  }

  TextButton {
    id: winnerScreen
    blinkIntervall: 200
    text: qsTr("Winner ...")+translation.language
    anchors.centerIn: scene.gameWindowAnchorItem
    font: fontHUD
  }

  TextButton {
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 10
    onClicked: {
      audioManager.stopMusic()
      audioManager.playMusic(audioManager.idMusicBG)
      audioManager.play(audioManager.idBUTTON)
      sceneLoader.activateResultScene()
    }
    text: qsTr("RESULTS")+translation.language
  }

  function open() {
    opacity = 1
    if(settingsManager.balance1 > settingsManager.balance2) {
      winnerScreen.text = qsTr("Player 1 won!")+translation.language
    } else if(settingsManager.balance1 < settingsManager.balance2) {
      winnerScreen.text = qsTr("Player 2 won!")+translation.language
    } else {
      winnerScreen.text = qsTr("Draw!")+translation.language
    }
  }
}
