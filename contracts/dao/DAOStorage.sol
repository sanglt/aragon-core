pragma solidity ^0.4.11;

import "./AbstractDAO.sol";

contract UIntStorage {
  mapping (bytes32 => uint256) uintStorage;

  function storageSet(bytes32 key, uint256 value) internal {
    uintStorage[key] = value;
  }

  function storageGet(bytes32 key) constant internal returns (uint256) {
    return uintStorage[key];
  }
}

contract DAOStorage is AbstractDAO, UIntStorage {
  bytes32 constant kernelKey = sha3(0x00, 0x01);
  bytes32 constant selfKey = sha3(0x00, 0x00);

  function DAOStorage() {
    // Setup getters allowed to return values
    setReturnSize(0xb18fe4f3, 32); // canPerformAction(...): returns 1 bool (ABI encoded to 32 bytes)
  }

  function setKernel(address kernelAddress) internal {
    storageSet(kernelKey, uint256(kernelAddress));
  }

  function setSelf(address selfAddress) internal {
    storageSet(selfKey, uint256(selfAddress));
  }

  function getSelf() constant public returns (address) {
    return address(storageGet(selfKey));
  }

  function getKernel() constant public returns (address) {
    return address(storageGet(kernelKey));
  }

  function setReturnSize(bytes4 _sig, uint _size) internal {
    storageSet(getKeyForReturnSize(_sig), _size);
  }

  function getReturnSize(bytes4 _sig) internal constant returns (uint32) {
    return uint32(storageGet(getKeyForReturnSize(_sig)));
  }

  function getKeyForReturnSize(bytes4 _sig) internal constant returns (bytes32) {
    return sha3(0x00, 0x02, _sig);
  }
}
