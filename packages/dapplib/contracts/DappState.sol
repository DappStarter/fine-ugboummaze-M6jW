// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "./interfaces/IDappState.sol";
import "./DappLib.sol";


/********************************************************************************************/
/* This contract is auto-generated based on your choices in DappStarter. You can make       */
/* changes, but be aware that generating a new DappStarter project will require you to      */
/* merge changes. One approach you can take is to make changes in Dapp.sol and have it      */
/* call into this one. You can maintain all your data in this contract and your app logic   */
/* in Dapp.sol. This lets you update and deploy Dapp.sol with revised code and still        */
/* continue using this one.                                                                 */
/********************************************************************************************/

contract DappState is IDappState 
///+interfaces
{
    // Allow DappLib(SafeMath) functions to be called for all uint256 types
    // (similar to "prototype" in Javascript)
    using DappLib for uint256; 


/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ S T A T E @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

    // Account used to deploy contract
    address private contractOwner;                  

/*>>>>>>>>>>>>>>>>>>>>>>>>>>> ACCESS CONTROL: ADMINISTRATOR ROLE  <<<<<<<<<<<<<<<<<<<<<<<<<<*/
    // Track authorized admins count to prevent lockout
    uint256 private authorizedAdminsCount = 1;                      

    // Admins authorized to manage contract
    mapping(address => uint256) private authorizedAdmins;                      


/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ C O N S T R U C T O R @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/

    constructor()  
    {
        contractOwner = msg.sender;       

/*>>>>>>>>>>>>>>>>>>>>>>>>>>> ACCESS CONTROL: ADMINISTRATOR ROLE  <<<<<<<<<<<<<<<<<<<<<<<<<<*/
        // Add account that deployed contract as an authorized admin
        authorizedAdmins[msg.sender] = 1;       

    }

/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ E V E N T S @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/



/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ M O D I F I E R S @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/


/*>>>>>>>>>>>>>>>>>>>>>>>>>>> ACCESS CONTROL: ADMINISTRATOR ROLE  <<<<<<<<<<<<<<<<<<<<<<<<<<*/
    /**
    * @dev Modifier that requires the function caller to be a contract admin
    */
    modifier requireContractAdmin()
    {
        require(isContractAdmin(msg.sender), "Caller is not a contract administrator");
        // Modifiers require an "_" which indicates where the function body will be added
        _;
    }


/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ F U N C T I O N S @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
/*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/


/*>>>>>>>>>>>>>>>>>>>>>>>>>>> ACCESS CONTROL: ADMINISTRATOR ROLE  <<<<<<<<<<<<<<<<<<<<<<<<<<*/
    /**
    * @dev Checks if an account is an admin
    *
    * @param account Address of the account to check
    */
    function isContractAdmin
                            (
                                address account
                            ) 
                            public 
                            view
                            returns(bool) 
    {
        return authorizedAdmins[account] == 1;
    }


    /**
    * @dev Adds a contract admin
    *
    * @param account Address of the admin to add
    */
    function addContractAdmin
                            (
                                address account
                            ) 
                            external 
                            requireContractAdmin
    {
        require(account != address(0), "Invalid address");
        require(authorizedAdmins[account] < 1, "Account is already an administrator");

        authorizedAdmins[account] = 1;
        authorizedAdminsCount++;
    }

    /**
    * @dev Removes a previously added admin
    *
    * @param account Address of the admin to remove
    */
    function removeContractAdmin
                            (
                                address account
                            ) 
                            external 
                            requireContractAdmin
    {
        require(account != address(0), "Invalid address");
        require(authorizedAdminsCount >= 2, "Cannot remove last admin");

        delete authorizedAdmins[account];
        authorizedAdminsCount--;
    }

    /**
    * @dev Removes the last admin fully decentralizing the contract
    *
    * @param account Address of the admin to remove
    */
    function removeLastContractAdmin
                            (
                                address account
                            ) 
                            external 
                            requireContractAdmin
    {
        require(account != address(0), "Invalid address");
        require(authorizedAdminsCount == 1, "Not the last admin");

        delete authorizedAdmins[account];
        authorizedAdminsCount--;
    }



//  Example functions that demonstrate how to call into this contract that holds state from
//  another contract. Look in ~/interfaces/IDappState.sol for the interface definitions and
//  in Dapp.sol for the actual calls into this contract.

    /**
    * @dev This is an EXAMPLE function that illustrates how functions in this contract can be
    *      called securely from another contract to READ state data. Using the Contract Access 
    *      block will enable you to make your contract more secure by restricting which external
    *      contracts can call functions in this contract.
    */
    function getContractOwner()
                                external
                                view
                                override
                                returns(address)
    {
        return contractOwner;
    }

    uint256 counter;    // This is an example variable used only to demonstrate calling
                        // a function that writes state from an external contract. It and
                        // "incrementCounter" and "getCounter" functions can (should?) be deleted.
    /**
    * @dev This is an EXAMPLE function that illustrates how functions in this contract can be
    *      called securely from another contract to WRITE state data. Using the Contract Access 
    *      block will enable you to make your contract more secure by restricting which external
    *       contracts can call functions in this contract.
    */
    function incrementCounter
                            (
                                uint256 increment
                            )
                            external
                            override
                            // Enable the modifier below if using the Contract Access feature
                            // requireContractAuthorized
    {
        // NOTE: If another contract is calling this function, then msg.sender will be the address
        //       of the calling contract and NOT the address of the user who initiated the
        //       transaction. It is possible to get the address of the user, but this is 
        //       spoofable and therefore not recommended.
        
        require(increment > 0 && increment < 10, "Invalid increment value");
        counter = counter.add(increment);   // Demonstration of using SafeMath to add to a number
                                            // While verbose, using SafeMath everywhere that you
                                            // add/sub/div/mul will ensure your contract does not
                                            // have weird overflow bugs.
    }

    /**
    * @dev This is an another EXAMPLE function that illustrates how functions in this contract can be
    *      called securely from another contract to READ state data. Using the Contract Access 
    *      block will enable you to make your contract more secure by restricting which external
    *      contracts can call functions in this contract.
    */
    function getCounter()
                                external
                                view
                                override
                                returns(uint256)
    {
        return counter;
    }

}   


