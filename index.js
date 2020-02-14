import {
  AppRegistry
} from 'react-native';

import RNDeviceList from './src/features/device/RNDeviceList';
import RNHome from './src/features/home/RNHome'

// Register All Modules
AppRegistry.registerComponent('RNHome', () => RNHome);
AppRegistry.registerComponent('RNDeviceList', () => RNDeviceList);