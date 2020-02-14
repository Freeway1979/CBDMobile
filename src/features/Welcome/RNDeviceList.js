import React from 'react';
import { StyleSheet, Text, View, TouchableHighlight, findNodeHandle, NativeModules } from 'react-native';

const { DeviceListManager } = NativeModules;

export default class RNDeviceList extends React.Component {

  componentDidMount() {
    this.textTag1 = findNodeHandle(this.refs['textTag1']);
  }

  render() {
    var contents = this.props['scores'].map((score) => (
      <Text key={score.name}>
        {score.name}:{score.value}
        {'\n'}
      </Text>
    ));
    return (
      <View style={styles.container}>
        <Text style={styles.highScoresTitle}>Hello,World!This is a React Native screen.</Text>
        <TouchableHighlight
          ref='textTag1'
          onPress={() => { DeviceListManager.popMessage(this.textTag1, 'Hello,I am from Device List') }}
        >
          <Text style={styles.highScoresTitle}>Say Hello to Native</Text>
        </TouchableHighlight>
        <Text style={styles.scores}>{contents}</Text>
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
    textAlign: 'center',
    margin: 10,
  },
  scores: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});