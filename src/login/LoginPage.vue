<template>
<b-container class="bv-example-row bv-example-row-flex-cols">
   <b-row align-v="center" >
    <div class="login col-md-8 offset-md-2">
       <!--  <div v-if="loading" class="container-loading">
            <img src="/loading.gif" alt="Loading Icon" class="loader-img">
        </div> -->
        <p class="errorMsg">{{ error }}</p>

        <form @submit.prevent="onSubmit" >
            <input type="text" class="form-control" placeholder="User Name" v-model="username">
            <input type="password" class="form-control" placeholder="Password" v-model="password">
            <button type="submit" class="btn btn-primary offset-md-10 ">Login</button>
        </form>
    </div>
     </b-row>
 </b-container>
</template>


<script>
import { required } from 'vuelidate/lib/validators';
import { router } from '@/_helpers';
import { authenticationService } from '@/_services';

export default {
    data () {
        return {
            username: '',
            password: '',
            submitted: false,
            loading: false,
            returnUrl: '',
            error: ''
        };
    },
    validations: {
      username: { required },
      password: { required }
    },
    created () {
        if (authenticationService.currentUserValue) {
            return router.push('/');
        }
        this.returnUrl = this.$route.query.returnUrl || '/';
    },
    methods: {
        onSubmit () {
            this.submitted = true;

            this.loading = true;
            authenticationService.login(this.username, this.password)
                .then(
                    user => router.push(this.returnUrl),
                    error => {
                        this.error = "Somethsomething went wrong!";
                        this.loading = false;
                    }
                );
        }
    }
};</script>