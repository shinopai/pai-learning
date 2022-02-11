<template>
  <div class="box flex justify-end">
    <span v-if="isLiked" @click="unlikePost(currentUserId)"><i class="fa-solid fa-heart text-xl cursor-pointer mr-2 text-red-500" style="vertical-align: -5px;"></i></span>
    <span v-else @click="likePost(currentUserId)"><i class="fa-solid fa-heart text-xl cursor-pointer mr-2" style="vertical-align: -5px;"></i></span>
    <span>{{ allLikes }}</span>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue'
import Axios from 'axios'

Axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  setup() {
    const allLikes = ref()
    const url = location.href
    const postId = url.split("/")[(url.split("/").length) - 1]
    const currentUserId = ref()
    let isLiked = ref(Boolean)

    // get current user id
    const getCurrentUserId = async () => {
      await Axios.get('/api/v1/user')
                 .then( res => {
                   currentUserId.value = res.data
                   checkLike(currentUserId.value)
                 })
                 .catch( err => {
                   console.log(err.response)
                 })
    }

    // get this post's all likes
    const getAllLikes = async () => {
      await Axios.get('/api/v1/posts/' + postId + '/all_likes')
                 .then( res => {
                   allLikes.value = res.data
                 })
                 .catch( err => {
                   console.log(err.response.data)
                 })
    }

     // like this post
    const likePost = async (userId) => {
      await Axios.post('/api/v1/users/' + userId + '/posts/' + postId + '/like_post')
                 .then( res => {
                    getCurrentUserId()
                    getAllLikes()
                 })
                 .catch( err => {
                   console.log(err.response.data)
                 })
    }

    // unlike this post
    const unlikePost = async (userId) => {
      await Axios.delete('/api/v1/users/' + userId + '/posts/' + postId + '/unlike_post')
                 .then( res => {
                    getCurrentUserId()
                    getAllLikes()
                 })
                 .catch( err => {
                   console.log(err.response.data)
                 })
    }

    // check if current user liking this post
    const checkLike = async (userId) => {
      await Axios.get('/api/v1/users/' + userId + '/posts/' + postId + '/check')
                 .then( res => {
                   console.log(res.data)
                   isLiked.value = res.data
                 })
                 .catch( err => {
                   console.log(err.response)
                 })
    }

    onMounted(() => {
      getCurrentUserId()
      getAllLikes()
    })

    return {
      currentUserId, isLiked, allLikes, likePost, unlikePost }
  },
}
</script>
