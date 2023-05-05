<script setup lang="ts">
import Web3 from "web3";
import abi from '../../../../back/build/contracts/Voting.json'

const web3 = new Web3('http://localhost:7545');
const contractAddress = "0x7C89e830524961D4AC8dA4fF4fC91B62531ecD6c"
console.log(abi.abi)
const contract = new web3.eth.Contract(abi.abi, contractAddress);
console.log(contract)
</script>

<template>

</template>

<style scoped>

</style>