import { JwtHelper } from 'angular2-jwt';
import { injectable } from '@angular/core';
import { Http } from '@angular/http';

function isLoggedIn() {
    return tokenNotExpired();
    // replace below code, it do a same thing
    let token = localStorage.getItem('token');

    if (!token)
        return false;

    let jwtHelper = new jwtHelper();
    let expirationDate = jwtHelper.getTokenExpirationDate(token);
    let isExpired = jwtHelper.isTokenExpired(token);
    let currentUser = jwtHelper.decodeToken(token);
    return !isExpired;
}