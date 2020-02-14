import React from 'react';
import {
  AppRegistry, StyleSheet, Text, View,
  TouchableHighlight,
  Button,
  findNodeHandle,
  NativeModules
} from 'react-native';
import RNDeviceList from './src/features/Welcome/RNDeviceList'
const { ReactNativeHelper } = NativeModules;


class RNHelloWorld extends React.Component {
  constructor(props) {
    super(props);

    // alert(JSON.stringify(props));

    this.rootTag = props['rootTag'];

  }
  componentDidMount() {
    this.buttonTag = findNodeHandle(this.refs['refButton']);
    this.textTag1 = findNodeHandle(this.refs['textTag1']);
    this.textTag2 = findNodeHandle(this.refs['textTag2']);
    this.textTag3 = findNodeHandle(this.refs['textTag3']);
  }
  render() {
    var contents = this.props['members'].map((score) => (
      <Text key={score.name}>
        Name:{score.name} Age:{score.age}
        {'\n'}
      </Text>
    ));
    return (
      <View style={styles.container}>
        <Text style={styles.highScoresTitle, {color: '#333333'}}>Welcome to React Native.</Text>
        <Text style={styles.scores}>{contents}</Text>
        <TouchableHighlight
          ref='textTag1'
          onPress={() => { ReactNativeHelper.sayHello(this.textTag1,'Hello,I am from React Native JS') }}
        >
          <Text style={styles.highScoresTitle}>Say Hello to Native</Text>
        </TouchableHighlight>

        {/* <Button
          ref='refButton'
          title={'Go to second native screen'}
          onPress={() => { ReactNativeHelper.navigateToScreen(this.buttonTag,'SecondViewController') }}
        >
        </Button> */}

        <TouchableHighlight
          ref='textTag2'
          onPress={() => { ReactNativeHelper.pushScreen(this.textTag2,'SecondViewController') }}
        >
          <Text style={styles.highScoresTitle}>Push second native screen</Text>
        </TouchableHighlight>

        <TouchableHighlight
          ref='textTag3'
          onPress={() => { ReactNativeHelper.presentScreen(this.textTag3,'SecondViewController') }}
        >
          <Text style={styles.highScoresTitle}>Present second native screen</Text>
        </TouchableHighlight>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
  },
  highScoresTitle: {
    fontSize: 20,
    color: '#049fd9',
    textAlign: 'center',
    margin: 10,
  },
  scores: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

// Module name
AppRegistry.registerComponent('RNHelloWorld', () => RNHelloWorld);
// AppRegistry.registerComponent('RNDeviceList', () => RNDeviceList);