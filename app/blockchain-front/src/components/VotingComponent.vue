<script setup lang="ts">
import Web3 from "web3";

const fs = require('fs')
const contract = JSON.parse(fs.readFileSync("../../../../back/build/contracts/Voting.json"))
console.log(contract)

const web3 = new Web3('http://localhost:8545');
const contractAddress = "0xEDE4F40fADb30cD0DD7f04B43422175086b35121"
</script>

<template>

</template>

<style scoped>

</style>