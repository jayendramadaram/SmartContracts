// SPDX-License-Identifier: MIT 
// can give credits to jayy 😌 @jayendra__02 -- ig
pragma solidity >=0.8.0;

contract FundKids {

    // value eth of parent owner
    address ContractOwner;

    constructor () {
        ContractOwner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == ContractOwner, "BROOO NO MALPRACTICING IN THIS ERA CALL CONTRACT OWNER TO DO THIS JOB");
        _;
    }

    struct Payee {
        address payable PayeeWallet;
        uint TimeToWithDraw;
        uint amount;
    }

    Payee[] public payees;

    function  AddPayee(address payable PayeeWallet,uint TimeToWithDraw) public onlyOwner {
        payees.push(Payee(
            PayeeWallet,
            block.timestamp + TimeToWithDraw*86,
            0
        ));
    }

    function viewbal() public view returns(uint) {
        return address(this).balance;
    }


    function deposit(address payable KIDSwallet) payable public onlyOwner {
        for (uint i = 0 ;i < payees.length ; i++) {
            if (payees[i].PayeeWallet == KIDSwallet ) {
               payees[i].amount += msg.value;
            }
        }
    } 

    function getIndex(address payeeWallet) view private returns(uint) {
        for(uint i = 0; i < payees.length; i++) {
            if (payees[i].PayeeWallet == payeeWallet) {
                return i;
            }
        }
        return 999;
    }

    function approve(uint i) private returns(bool){
        require(block.timestamp > payees[i].TimeToWithDraw, "You cannot withdraw yet");
        if (block.timestamp > payees[i].TimeToWithDraw) {
            return true;
        } else {
            return false;
        }
    }

    function WithdrawMuney() public {
        uint i  =getIndex(msg.sender);
        require(i < 999 , "NAHH Buddy your time hasnt arrived Yet");
        require(approve(i) , "You cannot withdraw yet");
        payees[i].PayeeWallet.transfer(payees[i].amount);
        payees[i].amount = 0;
    }



    // number of kids and their respective wallets
 
    // send their divided share to their wallet based on time { current time stamp + left of years }

    // pop grand children once funding is complete 

    // fill the funding wallet 

    // ability to withdraw and check statements 
    
}
