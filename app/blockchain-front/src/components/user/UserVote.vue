<script setup lang="ts">
import "bootstrap/dist/css/bootstrap.css";
import "bootstrap/dist/js/bootstrap.js";
import {ref} from "vue";

const props = defineProps<{
    contractvar: any,
    accountsvar: any
}>()

const proposals = ref([])
props.contractvar.methods.getProposalsLength().call((err, res: number) => {
    for (let i = 0; i < res; i++) {
        props.contractvar.methods.proposals(i).call((err1, res1) => {
            proposals.value.push(res1)
        })
    }
})

const vote = (id: number) => {
    props.contractvar.methods.vote(id).send({from: props.accountsvar.value[0]})
}

</script>

<template>
<div class="container py-2">
    <div class="row">
        <table class="table" id="myTable">
            <tr v-for="item in props">
                <th style="width: 80%;" scope="row">{{ item.description }}</th>
                <td style="width: 20%;"><button class="btn btn-outline-success " v-on:click="vote(proposals.indexOf(item))">Vote</button></td>
            </tr>
        </table>
    </div>
</div>
</template>

<style scoped>

</style>