pragma solidity ^0.4.11;

import "../kernel/AbstractKernel.sol";
import "./AbstractApplication.sol";

contract Application is AbstractApplication {
  AbstractKernel.DAOMessage dao_msg;
  address public dao;

  modifier onlyDAO {
    require(dao == 0 || msg.sender == dao);
    _;
  }

  function Application(address newDAO) {
    setDAO(newDAO);
  }

  function setDAO(address newDAO) onlyDAO {
    dao = newDAO;
  }

  function setDAOMsg(address sender, address token, uint value) onlyDAO {
    dao_msg.sender = sender;
    dao_msg.token = token;
    dao_msg.value = value;
  }
}
