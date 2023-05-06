<script setup lang="ts">
import "bootstrap/dist/css/bootstrap.css";
import "bootstrap/dist/js/bootstrap.js";
import {ref} from "vue";

const props = defineProps<{
    contractvar: any
}>()

const proposals = ref([])
props.contractvar.methods.getProposalsLength().call((err, res: number) => {
    for (let i = 0; i < res; i++) {
        props.contractvar.methods.proposals(i).call((err1, res1) => {
            proposals.value.push(res1)
        })
    }
})

const emit = defineEmits<{
    (e: 'endProposal'): void
}>()

</script>

<template>
    <div class="container py-2">
        <div class="row my-4">
            <table class="table" id="myTable">
                <tr v-for="item in proposals">
                    <th style="width: 80%;" scope="row">{{ item.description }}</th>
                </tr>
            </table>
        </div>
        <div class="row justify-content-center">
            <button class="btn btn-primary" v-on:click="emit('endProposal')">Finish proposals</button>
        </div>
    </div>
</template>

<style scoped>

</style>