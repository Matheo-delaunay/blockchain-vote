<script setup lang="ts">
import Voting from '../../../back/build/contracts/Voting.json'
import {onMounted, ref} from "vue";
import getWeb3 from './assets/getWeb3.js'
import InputWhiteList from "@/components/admin/InputWhiteList.vue";
import ShowProposal from "@/components/admin/ShowProposal.vue";
import StartVote from "@/components/admin/StartVote.vue";
import FinishVote from "@/components/admin/FinishVote.vue";
import TallyVote from "@/components/admin/TallyVote.vue";
import AddProposal from "@/components/user/AddProposal.vue";
import Navbar from "@/components/Navbar.vue";
import ViewVotes from "@/components/user/ViewVotes.vue";


const web3var = ref(null)
const accountsvar = ref(null)
const contractvar = ref(null)
const userAddressvar = ref(null)
const isOwnervar = ref(false)



onMounted(async () => {
    try {
        // Get network provider and web3 instance.
        const web3 = await getWeb3()

        // Use web3 to get the user's accounts.
        /* on récupère le tableau des comptes sur le metamask du user */
        const accounts = await web3.eth.getAccounts()

        // Get the contract instance.
        const networkId = await web3.eth.net.getId()
        const deployedNetwork = Voting.networks[networkId]
        console.log("deployedNetwork", deployedNetwork)
        /* Création de l'objet de contrat avec l'abi, le deployedNetwork et son address  */
        const instance = new web3.eth.Contract(
            Voting.abi,
            deployedNetwork && deployedNetwork.address
        )

        // Set web3, accounts, and contract to the state, and then proceed with an
        // example of interacting with the contract's methods.
        web3var.value = web3
        accountsvar.value = accounts
        contractvar.value = instance
        userAddressvar.value = accountsvar.value[0]

        // Check if the user is the owner
        const owner = await instance.methods.owner().call()
        if (userAddressvar.value === owner) {
            isOwnervar.value = true
        }
    } catch (error) {
        // Catch any errors for any of the above operations.
        alert(
            `Failed to load web3, accounts, or contract. Check console for details.`
        )
        console.error(error)
    }
})
const temp = []
const startProposal = (reactiveData:string[]) => {

    contractvar.value.methods.getProposalsLength().call((err, res) => {
        for (let i = 0; i<res; i++){
            contractvar.value.methods.proposals[i].call((err1, res1) => {
                temp.push(res1)
            })
        }
    }).then((result)=>console.log(result))
    //contractvar.value.methods.registerVoters(reactiveData).send({from: accountsvar.value[0]}).then((result)=>console.log(result))
    //contractvar.value.methods.startProposalsRegistration().send({from: accountsvar.value[0]}).then((result)=>console.log(result))

}

const endProposal = () => {
    contractvar.value.methods.endProposalsRegistration().send({from: accountsvar.value[0]}).then((result)=>console.log(result))
}

const makeProposal = (data) => {
    contractvar.value.methods.registerProposal(string)().send({from: accountsvar.value[0]}).then((result)=>console.log(result))
}

</script>

<template>
    <navbar :userAddressvar="userAddressvar"></navbar>
    <div v-if="isOwnervar" class="admin"><input-white-list @startVote="startProposal"></input-white-list></div>
    <div v-if="isOwnervar" class="admin"><show-proposal></show-proposal></div>
    <div v-if="isOwnervar" class="admin"><start-vote></start-vote></div>
    <div v-if="isOwnervar" class="admin"><finish-vote></finish-vote></div>
    <div v-if="!isOwnervar" class="user"><tally-vote></tally-vote></div>
    <div v-if="!isOwnervar" class="user"><add-proposal></add-proposal></div>
    <div v-if="!isOwnervar" class="user"><view-votes></view-votes></div>
</template>


<style scoped>
</style>
