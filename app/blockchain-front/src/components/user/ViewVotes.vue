<script setup lang="ts">
import {ref} from "vue";
import "bootstrap/dist/css/bootstrap.css";
import "bootstrap/dist/js/bootstrap.js";

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

console.log(proposals)

</script>

<template>
    <div class="container py-2">
        <div class="row">
            <table class="table" id="myTable">
                <tr v-for="item in proposals">
                    <th style="width: 80%;" scope="row">{{ item.description }}</th>
                    <td style="width: 20%;"><span>{{ item.voteCount }}</span></td>
                </tr>
            </table>
        </div>
    </div>
</template>

<style scoped>

</style>