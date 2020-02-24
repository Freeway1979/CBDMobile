import React from 'react';
import {
    StyleSheet, Text, View, FlatList, ActivityIndicator, NativeModules, NativeEventEmitter, findNodeHandle,
    TouchableWithoutFeedback, Platform
} from 'react-native';

const {DeviceListManager} = NativeModules;

export default class RNDeviceList extends React.Component {

    static defaultProps = {repos: []}

    constructor(props) {
        super(props);
        if (Platform.OS == 'android') {
            RNDeviceList.defaultProps.repos = JSON.parse(this.props.repos);
        } else {
            RNDeviceList.defaultProps.repos = this.props.repos
        }
    }

    componentDidMount() {
        this.deviceListTag = findNodeHandle(this.refs['deviceListRef']);
    }

    render() {
        return (
            <View style={styles.container}>
                {RNDeviceList.defaultProps.repos.length == 0 &&
                <ActivityIndicator size="large" color="#00000"/>
                }
                <FlatList
                    ref='deviceListRef'
                    data={RNDeviceList.defaultProps.repos}
                    keyExtractor={item => item.id.toString()}
                    renderItem={({item}) =>
                        <TouchableWithoutFeedback
                            ref='textTag3'
                            onPress={() => {
                                DeviceListManager.popMessage(this.deviceListTag, "You clicked " + item.full_name, (err, r) => console.log("Success"))
                            }}
                        >
                            <Text style={styles.item}>{item.full_name}</Text>
                        </TouchableWithoutFeedback>
                    }
                />
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        paddingTop: 100,
        paddingBottom: 80,
        justifyContent: 'center',
        alignItems: 'center',
    },
    highScoresTitle: {
        fontSize: 20,
        color: '#049fd9',
        textAlign: 'center',
        margin: 10,
    },
    item: {
        padding: 10,
        fontSize: 18,
        height: 44,
    },
});