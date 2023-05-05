<script setup lang="ts">
import Web3 from "web3";
import abi from '../../../../back/build/contracts/Voting.json'

const web3 = new Web3('http://localhost:7545');
const contractAddress = "0xffcC7045eec3EdEb361E3AaDD93F66655b0e5E62"
console.log(abi.abi)
const contract = new web3.eth.Contract(abi.abi, contractAddress);
console.log(contract)

contract.methods.startVotingSession().send({from: '0x0E1570Cf1d65897745f05545f32A450f9B75404F'}).then((result: any) => console.log(result))
</script>

<template>

</template>

<style scoped>

</style>